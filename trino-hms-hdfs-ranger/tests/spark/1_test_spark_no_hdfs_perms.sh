#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo "- INFO: Reusing policies."
echo "- INFO: Create table."
echo "- INFO: User [spark] shouldn't be able to create table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_EXTERNAL_TABLE_CREATION_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "$DEFAULT_DB.$SPARK_TABLE")
scala_msg=$(base64encode "Permission denied: user=spark, access=WRITE")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_EXTERNAL_TABLE_CREATION_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
