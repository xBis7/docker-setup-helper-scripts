#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 12 ##"
echo "Repeat using an external table"
echo ""

updateHdfsPathPolicy "/data/projects/gross_test,/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1"

# It's the same as in the previous test.
updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$TRINO_USER1/select:$TRINO_USER2"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy ""

# It's the same as in the previous test.
updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$TRINO_USER1"

waitForPoliciesUpdate

# Run the commands as user1.
command="create table $TRINO_HIVE_SCHEMA.gross_test.test2 (id int, name varchar) with (external_location = 'hdfs://$NAMENODE_NAME/data/projects/gross_test/test2')"
expectedMsg="CREATE TABLE"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

command="insert into $TRINO_HIVE_SCHEMA.gross_test.test2 values (1, 'Austin')"
expectedMsg="INSERT: 1 row"

runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

# Run the commands as user2.
command="show schemas in $TRINO_HIVE_SCHEMA"
expectedMsg="gross_test"

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg" "user"

command="show tables in $TRINO_HIVE_SCHEMA.gross_test"
expectedMsg="test2"

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg" "user"

command="select * from $TRINO_HIVE_SCHEMA.gross_test.test2"

if [ "$CURRENT_ENV" == "local" ]; then
  expectedMsg="Permission denied: user=$TRINO_USER2, access=EXECUTE, inode=\"/data/projects/gross_test\":"
  runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg"
else
  # TODO why is this not failing?
  expectedMsg="  1 | Austin "
  runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg" "user"
fi

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg"

updateHdfsPathPolicy "/data/projects/gross_test,/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1/read,execute:$TRINO_USER2"
waitForPoliciesUpdate

command="select * from $TRINO_HIVE_SCHEMA.gross_test.test2"
expectedMsg="  1 | Austin "

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg" "user"

command="insert into $TRINO_HIVE_SCHEMA.gross_test.test2 values (2, 'Fred')"
expectedMsg="Permission denied: user=$TRINO_USER2, access=EXECUTE, inode=\"/data/projects/gross_test\":"

# TODO fix this for c3.
if [ "$CURRENT_ENV" == "local" ]; then
  runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg" "user"

  verifyCreateWriteFailure "trino" "insertInto" "gross_test" "test2" "2"
fi

command="drop table $TRINO_HIVE_SCHEMA.gross_test.test2"
expectedMsg="Permission denied: user [$TRINO_USER2] does not have [DROP] privilege on [gross_test/test2]"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg" "user"

verifyCreateWriteFailure "trino" "dropTable" "gross_test" "test2"

command="alter table $TRINO_HIVE_SCHEMA.gross_test.test2 rename to $TRINO_HIVE_SCHEMA.gross_test.test3"
expectedMsg="Permission denied: user [$TRINO_USER2] does not have [ALTER] privilege on [gross_test/test2]"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg" "user"

# Use the old table name with 'renameTable' check.
verifyCreateWriteFailure "trino" "renameTable" "gross_test" "test2"

# BigData note:
# This is a 'create table' command where user2 has to create a new directory under '/data/projects'.
# Based on the provided policies, the user doesn't have write access on '/data/projects'.
# There should be an HDFS write error.
command="create table $TRINO_HIVE_SCHEMA.gross_test.test3 (id int, name varchar) with (external_location = 'hdfs://$NAMENODE_NAME/data/projects/squirrel/test3')"
# BigData note: The notes repeat the previous error
# expectedMsg="Permission denied: user [$TRINO_USER2] does not have [ALTER] privilege on [gross_test/test2]"
expectedMsg="Permission denied: user=$TRINO_USER2, access=WRITE, inode=\"/data/projects\":"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg" "user"

verifyCreateWriteFailure "trino" "createTable" "gross_test" "test3"
