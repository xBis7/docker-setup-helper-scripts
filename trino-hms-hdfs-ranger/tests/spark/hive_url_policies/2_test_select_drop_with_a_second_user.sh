#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1

echo ""
echo "Test2-spark: ############### test select and drop with user 'games' ###############"
echo ""

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark,trino"
updateHiveDbAllPolicy "*" "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy "*" "read,write:spark"

waitForPoliciesUpdate

echo ""
echo "User 'games' has SELECT access. Show database should succeed."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "show databases")
scala_msg=$(base64encode "$GROSS_DB_NAME")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql $scala_msg games" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "Trying to drop database $GROSS_DB_NAME as user 'games'. User doesn't have permissions and operation should fail."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "drop database $GROSS_DB_NAME")
scala_msg=$(base64encode "Permission denied: user [games] does not have [DROP] privilege on [$GROSS_DB_NAME]")
# Add user 'games' as a parameter.
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg games" "$SPARK_TEST_SUCCESS_MSG" "false"
