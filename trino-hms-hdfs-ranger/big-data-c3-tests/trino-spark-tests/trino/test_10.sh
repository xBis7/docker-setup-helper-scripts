#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 10 ##"
echo "Create a managed table and attempt to access it as a different user"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "read,write,execute:$TRINO_USER1" "/*,/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db"

# It's the same as in the previous test.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$TRINO_USER1" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy ""

# It's the same as in the previous test.
updateHiveUrlPolicy "read,write:$TRINO_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"

waitForPoliciesUpdate

# Run the first commands as user1.
command="create table $TRINO_HIVE_SCHEMA.gross_test.test (id int, name varchar)"
expectedMsg="CREATE TABLE"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

command="insert into $TRINO_HIVE_SCHEMA.gross_test.test values (1, 'Austin')"
expectedMsg="INSERT: 1 row"

runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

# Run the next commands as user2.

command="show schemas in $TRINO_HIVE_SCHEMA"
expectedMsg="gross_test"

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg"

command="describe $TRINO_HIVE_SCHEMA.gross_test.test"
expectedMsg="Permission denied: user [$TRINO_USER2] does not have [SELECT] privilege on [gross_test]"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg"

# Provide select access for user2.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$TRINO_USER1/select:$TRINO_USER2" "gross_test"
waitForPoliciesUpdate

command="describe $TRINO_HIVE_SCHEMA.gross_test.test"
expectedMsg=""

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg"

# Change permissions here to get an HDFS ACLs error and
# check that creating a Ranger policy fixes it.
changeHdfsDirPermissions "$HIVE_WAREHOUSE_DIR/gross_test.db" 700

command="select * from $TRINO_HIVE_SCHEMA.gross_test.test"
# This is the expected error according to the BigData notes for ACL access drwx------.
# expectedMsg="Permission denied: user=$TRINO_USER2, access=EXECUTE, inode=\"/$HIVE_WAREHOUSE_DIR/gross_test.db\":"
expectedMsg="Failed to list directory: hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db/test"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg"

# In the BigData notes there is a screenshot updating the policies for the 2nd user,
# but the user isn't part of the policy update. Based on the screenshot, the policies should look like this
#
# updateHdfsPathPolicy "read,write,execute:$TRINO_USER1" "/*,/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db"
#
# But after the update, select is expected to work.
# If we don't include user 2, then nothing will change.

# Update the HDFS permissions to resolve the ACL execute error.
updateHdfsPathPolicy "read,write,execute:$TRINO_USER1,$TRINO_USER2" "/*,/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db"
waitForPoliciesUpdate

command="select * from $TRINO_HIVE_SCHEMA.gross_test.test"
expectedMsg="\"1\",\"Austin\""

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg"
