#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 4 ##"
echo "Create a database with CREATE (Hive), Read and Write (URL-based) and read, write and execute (HDFS)"
echo ""

updateHdfsPathPolicy "read,write,execute:$TRINO_USER1" "/data/projects/gross_test"

# It's the same as in the previous test.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$TRINO_USER1" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$TRINO_USER1"

# It's the same as in the previous test.
updateHiveUrlPolicy "read,write:$TRINO_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test"

waitForPoliciesUpdate

command="create schema $TRINO_HIVE_SCHEMA.gross_test with (location = 'hdfs://$NAMENODE_NAME/data/projects/gross_test/test.db')"

successMsg="CREATE SCHEMA"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER1" "$command" "shouldPass" "$successMsg"
