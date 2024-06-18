#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 2 ##"
echo "Create a database without having read,write,execute HDFS permissions"
echo ""

updateHdfsPathPolicy "read,write,execute:$HDFS_USER" "/*"

updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1"

# It's the same as in the previous test.
updateHiveUrlPolicy "read:$SPARK_USER1"

waitForPoliciesUpdate

# 'data/projects' can be replaced by '$EXTERNAL_HIVE_DB_PATH'
command="spark.sql(\"create database gross_test location '/data/projects/gross_test/gross_test.db'\")"

hdfsLocation="hdfs://$NAMENODE_NAME/data/projects/gross_test/gross_test.db"
expectedErrorMsg="Permission denied: user [$SPARK_USER1] does not have [WRITE] privilege on [[$hdfsLocation, $hdfsLocation/]]"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER1" "$command" "shouldFail" "$expectedErrorMsg"
