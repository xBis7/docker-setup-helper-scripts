#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 4 ##"
echo "Drop the database as another user (e.g. user2) without access"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "read,write,execute:$SPARK_USER1" "/*"

updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2" "gross_test"

updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"

# It's the same as in the previous test.
updateHiveUrlPolicy "read,write:$SPARK_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test"

waitForPoliciesUpdate

command="spark.sql(\"drop database gross_test\")"

# If we want the operation to fail with a DROP error, then we need to provide SELECT access for user2.
expectedErrorMsg="Permission denied: user [$SPARK_USER2] does not have [DROP] privilege on [gross_test]"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"
