#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Cleanup data ##"
echo "Delete schema created by Spark tests"
echo ""

updateHdfsPathPolicy "/*" "read,write,execute:$TRINO_USER1"

updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$TRINO_USER1"

updateHiveDefaultDbPolicy "select:$TRINO_USER1"

updateHiveUrlPolicy "/*" "read,write:$TRINO_USER1"

waitForPoliciesUpdate

command="drop schema hive.gross_test cascade;"

expectedMsg="DROP SCHEMA"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"

# Cleanup the HDFS directories to avoid unexpected errors such as
# 'Query 20240702_181249_00038_2rcvf failed: Malformed ORC file. Invalid postscript [hdfs://namenode/data/projects/gross_test/test2/part-00000-0f5f31b1-766b-4088-8e7a-66425b8d1985-c000.snappy.parquet]'

# drop schema will also delete "$HIVE_WAREHOUSE_DIR/gross_test.db"
deleteHdfsDir "data/projects/gross_test"

# Create the directory again as empty.
createHdfsDir "data/projects/gross_test"
