#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 11 ##"
echo "Attempt various DDL operations against the managed table as a different user"
echo ""

# BigData note: There are no notes about making policy changes.
# That prevents the create table call below from getting the Execute error it is supposed to get.
# So we remove HDFS access for user2 here:
updateHdfsPathPolicy "/data/projects/gross_test,/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1"

# BigData note: In order to get the expected errors then user2 must have select access.
# The select that has been added here, isn't part of the BigData notes.
updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$TRINO_USER1/select:$TRINO_USER2"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy ""

# It's the same as in the previous test.
updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$TRINO_USER1"

waitForPoliciesUpdate

# Run the commands as user2.
command="drop table $TRINO_HIVE_SCHEMA.gross_test.test"
expectedMsg="Permission denied: user [$TRINO_USER2] does not have [DROP] privilege on [gross_test/test]"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg" "user"

command="alter table $TRINO_HIVE_SCHEMA.gross_test.test rename to $TRINO_HIVE_SCHEMA.gross_test.test2"
expectedMsg="Permission denied: user [$TRINO_USER2] does not have [ALTER] privilege on [gross_test/test]"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg" "user"

command="create table $TRINO_HIVE_SCHEMA.gross_test.test2 (id int, greeting varchar)"
expectedMsg="Permission denied: user=$TRINO_USER2, access=EXECUTE, inode=\"/$HIVE_WAREHOUSE_DIR/gross_test.db\":"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg" "user"
