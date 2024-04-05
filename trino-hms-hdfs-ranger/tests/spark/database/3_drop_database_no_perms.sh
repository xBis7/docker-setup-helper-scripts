#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo "- INFO: Reusing policies."
echo "- INFO: Drop database."
echo "- INFO: User [spark] shouldn't be able to drop database."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(echo -n "drop database if exists poc_db cascade" | base64)
scala_msg=$(echo -n "Permission denied: user [spark] does not have [DROP] privilege on [poc_db]" | base64)
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
