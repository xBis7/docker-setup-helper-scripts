#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 8 ##"
echo "Create a managed table"
echo ""

# BigData note: "/*" isn't part of the BigData notes but it must have been added in a different policy.
# If it's not there, then we get this error
#
# ==========================
# Running trino command: 'insert into hive.gross_test.test values (1, 'Austin')'
# --------------------------
#
# Query 20240704_105000_00008_b6t3t failed: Create temporary directory for hdfs://namenode/opt/hive/data/gross_test.db/test failed: Permission denied: user=trino, access=WRITE, inode="/":hadoop:supergroup:drwxr-xr-x
updateHdfsPathPolicy "read,write,execute:$TRINO_USER1" "/*,/data/projects/gross_test,/$HIVE_WAREHOUSE_DIR/gross_test.db"

# It's the same as in the previous test.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$TRINO_USER1" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy ""

# It's the same as in the previous test.
updateHiveUrlPolicy "read,write:$TRINO_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test,hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"

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
