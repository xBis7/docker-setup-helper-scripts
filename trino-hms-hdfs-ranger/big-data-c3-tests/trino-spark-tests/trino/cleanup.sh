#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Cleanup data ##"
echo "Delete schema created by Spark tests"
echo ""

updateHdfsPathPolicy "read,write,execute:$TRINO_USER1" "/*"

updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$TRINO_USER1" "gross_test"

updateHiveDefaultDbPolicy "select:$TRINO_USER1"

updateHiveUrlPolicy "read,write:$TRINO_USER1" "/*"

waitForPoliciesUpdate

command="drop schema hive.gross_test cascade;"

expectedMsg="DROP SCHEMA"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected output message. For Trino all commands (whether successful or not) have an expected output message.
runTrino "$TRINO_USER1" "$command" "shouldPass" "$expectedMsg"
