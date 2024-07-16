#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 6 ##"
echo "Create a database using the default hive warehouse location"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "/data/projects/gross_test" "read,write,execute:$TRINO_USER1"

# It's the same as in the previous test.
updateHiveDbAllPolicy  "gross_test" "alter,create,drop,index,lock,select,update:$TRINO_USER1"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy ""

# It's the same as in the previous test.
updateHiveUrlPolicy  "hdfs://$NAMENODE_NAME/data/projects/gross_test" "read,write:$TRINO_USER1"

waitForPoliciesUpdate

command="create schema $TRINO_HIVE_SCHEMA.gross_test"

hdfsLocation="hdfs://$NAMENODE_NAME/$TRINO_HIVE_WAREHOUSE_DIR/gross_test.db"

expectedErrorMsg="Permission denied: user [$TRINO_USER1] does not have [WRITE] privilege on [[$hdfsLocation, $hdfsLocation/]]"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER1" "$command" "shouldFail" "$expectedErrorMsg"

verifyCreateWriteFailure "trino" "createDb" "gross_test"
