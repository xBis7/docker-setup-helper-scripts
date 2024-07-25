#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 10 ##"
echo "Create a managed table and attempt to access it as a different user"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "/data/projects/gross_test,/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1"

# It's the same as in the previous test.
updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$TRINO_USER1"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy ""

# It's the same as in the previous test.
updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$TRINO_USER1"

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

# The last parameter is the signing profile.
runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg" "user"

command="describe $TRINO_HIVE_SCHEMA.gross_test.test"
expectedMsg="Permission denied: user [$TRINO_USER2] does not have [SELECT] privilege on [gross_test]"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg" "user"

# Provide select access for user2.
updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$TRINO_USER1/select:$TRINO_USER2"
waitForPoliciesUpdate

command="describe $TRINO_HIVE_SCHEMA.gross_test.test"
expectedMsg=""

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg" "user"

# BigData note: Change permissions here to get an HDFS POSIX permissions error and
# check that creating a Ranger policy fixes it.
changeHdfsDirPermissions "$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" 744 "devpod"

command="select * from $TRINO_HIVE_SCHEMA.gross_test.test"
expectedMsg="Permission denied: user=$TRINO_USER2, access=EXECUTE, inode=\"/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db\":"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg" "user"

# BigData note: In the notes there is a screenshot updating the policies for the 2nd user,
# but the user isn't part of the policy update. Based on the screenshot, the policies should look like this
#
# updateHdfsPathPolicy "/data/projects/gross_test,/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1"
#
# But after the update, select is expected to work.
# If we don't include user2, then nothing will change.

# Update the HDFS permissions to resolve the POSIX permission execute error.
updateHdfsPathPolicy "/data/projects/gross_test,/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1,$TRINO_USER2"
waitForPoliciesUpdate

command="select * from $TRINO_HIVE_SCHEMA.gross_test.test"
expectedMsg="  1 | Austin "

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg" "user"
