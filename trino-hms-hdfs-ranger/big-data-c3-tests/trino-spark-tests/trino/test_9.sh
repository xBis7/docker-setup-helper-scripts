#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 9 ##"
echo "Create a database in a location where the user is denied write access via a Ranger policy"
echo ""

# BigData note: In the notes, this test has no policy screenshots or any commands.
# Just the title, an expected metadata SELECT error and a note 'Remove the Deny Condition and save your changes'.

# The schema already exists. If we remove the SELECT access and run 'create schema',
# we will get the expected error but it won't test the deny policy.

# To test the deny policy, we should
#   - have select access
#   - drop the schema
#   - try to create it
#   - get a WRITE error
#   - remove the deny policy
#   - create the schema again.

# It's the same as in the previous test.
updateHdfsPathPolicy "/data/projects/gross_test,/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1"

# Remove select access.
updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,update:$TRINO_USER1"

updateHiveDefaultDbPolicy ""

# Provide a deny policy.
# 2nd parameter: allow policies -> empty "-"
updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "-" "write:$TRINO_USER1"

waitForPoliciesUpdate

command="create schema $TRINO_HIVE_SCHEMA.gross_test"
expectedMsg="Permission denied: user [$TRINO_USER1] does not have [SELECT] privilege on [gross_test]"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER1" "$command" "shouldFail" "$expectedMsg"

# Here we shouldn't check if the DB creation has failed because the DB already exists.
# 'test_7.sh' created the db and we haven't dropped it since.
# We are testing that we don't have enough permissions to perform a read and see that
# the db exists.

# Provide select access.
updateHiveDbAllPolicy "gross_test" "select,alter,create,drop,index,lock,update:$TRINO_USER1"
waitForPoliciesUpdate

# Drop the schema.
command="drop schema $TRINO_HIVE_SCHEMA.gross_test"
expectedMsg="DROP SCHEMA"
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

# Verify the deny policy.
command="create schema $TRINO_HIVE_SCHEMA.gross_test"
expectedMsg="Permission denied: user [$TRINO_USER1] does not have [WRITE] privilege on [[hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db, hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db/]]"
runTrino "$TRINO_USER1" "$command" "shouldFail" "$expectedMsg"

verifyCreateWriteFailure "trino" "createDb" "gross_test"

# Remove the deny condition and restore the Hive URL policy.
updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$TRINO_USER1"
waitForPoliciesUpdate

# Create the schema again.
command="create schema $TRINO_HIVE_SCHEMA.gross_test"
expectedMsg="CREATE SCHEMA"

runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"
