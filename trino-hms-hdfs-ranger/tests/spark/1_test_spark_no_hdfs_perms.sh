#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo "- INFO: Reusing policies."
echo "- INFO: Create table."
echo "- INFO: User [spark] shouldn't be able to create table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_EXTERNAL_TABLE_CREATION_FOR_EXCEPTION_FILENAME
# We can achieve the correct variable substitution and space handling by encoding and decoding the string.
# -w 0, makes sure that the line length is ignored.
scala_sql=$(echo -n "default.spark_test_table" | base64)
scala_msg=$(echo -n "Permission denied: user=spark, access=WRITE" | base64)
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_EXTERNAL_TABLE_CREATION_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
