#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 12 ##"
echo "Repeat using an external table"
echo ""

updateHdfsPathPolicy "read,write,execute:$TRINO_USER1" "/*,/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db"

updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$TRINO_USER1/select:$TRINO_USER2" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy ""

# It's the same as in the previous test.
updateHiveUrlPolicy "read,write:$TRINO_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"

waitForPoliciesUpdate

# Run the commands as user1.
command="create table $TRINO_HIVE_SCHEMA.gross_test.test2 (id int, name varchar) with (external_location = 'hdfs://$NAMENODE_NAME/data/projects/gross_test/test2')"
expectedMsg="CREATE TABLE"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg"

command="insert into $TRINO_HIVE_SCHEMA.gross_test.test2 values (1, 'Austin')"
expectedMsg="INSERT: 1 row"

runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

# Run the commands as user2.
command="show schemas in $TRINO_HIVE_SCHEMA"
expectedMsg=""

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg"

command="show tables in $TRINO_HIVE_SCHEMA.gross_test"
expectedMsg=""

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg"

command="select * from $TRINO_HIVE_SCHEMA.gross_test.test2"
expectedMsg="Permission denied: user=$TRINO_USER2, access=EXECUTE, inode=\"/data/projects/gross_test\":"

runTrino "$TRINO_USER2" "$command" "shouldFail" "$expectedMsg"

updateHdfsPathPolicy "read,write,execute:$TRINO_USER1/read,execute:$TRINO_USER2" "/*,/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db"
waitForPoliciesUpdate

command="select * from $TRINO_HIVE_SCHEMA.gross_test.test2"
expectedMsg="\"1\",\"Austin\""

runTrino "$TRINO_USER2" "$command" "shouldPass" "$expectedMsg"


