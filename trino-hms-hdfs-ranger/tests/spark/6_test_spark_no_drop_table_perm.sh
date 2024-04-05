#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Reusing policies."
echo "- INFO: Drop table."
echo "- INFO: User [spark] shouldn't be able to drop table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(echo -n "drop table default.new_spark_test_table" | base64)
scala_msg=$(echo -n "Permission denied: user [spark] does not have [DROP] privilege on [default/new_spark_test_table]" | base64)
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
