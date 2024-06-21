#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 2 ##"
echo "Create a database without having read, write, execute HDFS and Read and Write URL-based permissions"
echo ""

updateHdfsPathPolicy "read,write,execute:$HDFS_USER" "/*"

updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$TRINO_USER1" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1"

# It's the same as in the previous test.
updateHiveUrlPolicy "read:$SPARK_USER1"

waitForPoliciesUpdate

hdfsLocation="hdfs://$NAMENODE_NAME/data/projects/gross_test/test.db"

command="create schema $TRINO_HIVE_SCHEMA.gross_test with (location = '$hdfsLocation')"

expectedErrorMsg="Permission denied: user [$TRINO_USER1] does not have [WRITE] privilege on [[$hdfsLocation, $hdfsLocation/]]"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runTrino "$TRINO_USER1" "$command" "shouldFail" "$expectedErrorMsg"
