#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 5 ##"
echo "Drop the database and recreate using the default Hive warehouse location"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$SPARK_USER1" "/*"

# It's the same as in the previous test.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"

# It's the same as in the previous test.
updateHiveUrlPolicy "read,write:$SPARK_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test"

waitForPoliciesUpdate

command="spark.sql(\"drop database gross_test\")"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER1" "$command" "shouldPass"

command="spark.sql(\"create database gross_test\")"

hdfsLocation="hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"
expectedErrorMsg="Permission denied: user [$SPARK_USER1] does not have [WRITE] privilege on [[$hdfsLocation, $hdfsLocation/]]"

runSpark "$SPARK_USER1" "$command" "shouldFail" "$expectedErrorMsg"

