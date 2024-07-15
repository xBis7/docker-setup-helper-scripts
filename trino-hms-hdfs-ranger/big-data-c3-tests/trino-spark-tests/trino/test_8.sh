#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 8 ##"
echo "Create a managed table"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$TRINO_USER1"

# It's the same as in the previous test.
updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$TRINO_USER1"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy ""

# It's the same as in the previous test.
updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$TRINO_USER1"

waitForPoliciesUpdate

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

command="select * from $TRINO_HIVE_SCHEMA.gross_test.test"
expectedMsg="\"1\",\"Austin\""

runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

command="drop table $TRINO_HIVE_SCHEMA.gross_test.test"
expectedMsg="DROP TABLE"

runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

# 'hdfs dfs -ls' and check data after drop.
listContentsOnHdfsPath "$HIVE_WAREHOUSE_DIR/gross_test.db" "shouldBeEmpty"
