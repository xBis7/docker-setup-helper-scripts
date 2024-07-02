#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 9 ##"
echo "Create a database in a location where the user is denied write access via a Ranger policy"
echo ""

# In the BigData notes, this test has no policy screenshots or any commands.
# Just the title, an expected metadata SELECT error and a note 'Remove the Deny Condition and save your changes'.

# 'create schema' doesn't need read access. You should get a WRITE error and not a SELECT error.
# Also, the next test assumes that the database exists.
# So, at the end we will restore the Hive URL policies and create the database.

# HDFS            ->  it doesn't make a difference whether we add a deny condition or not
#                     because we have already provided ACL access from a previous test.
#
# Hive db all     ->  we need select access in order to drop the db, we can remove it later
#                     but it won't make a difference for 'create schema' error.
# Hive default db ->  remove all access
#
# Hive URL        ->  provide a write deny condition

# It's the same as in the previous test.
updateHdfsPathPolicy "read,write,execute:$TRINO_USER1" "/*,/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db"

updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$TRINO_USER1" "gross_test"

updateHiveDefaultDbPolicy ""

# Provide a deny policy.
updateHiveUrlPolicy "-" "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "write:$TRINO_USER1"

waitForPoliciesUpdate

command="drop schema $TRINO_HIVE_SCHEMA.gross_test"
expectedMsg="DROP SCHEMA"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

command="create schema $TRINO_HIVE_SCHEMA.gross_test"
hdfsLocation="hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"
expectedMsg="Permission denied: user [$TRINO_USER1] does not have [WRITE] privilege on [[$hdfsLocation, $hdfsLocation/]]"

runTrino "$TRINO_USER1" "$command" "shouldFail" "$expectedMsg"

# Remove the deny condition and restore the Hive URL policy.
updateHiveUrlPolicy "read,write:$TRINO_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"
waitForPoliciesUpdate

command="create schema $TRINO_HIVE_SCHEMA.gross_test"
expectedMsg="CREATE SCHEMA"

runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"
