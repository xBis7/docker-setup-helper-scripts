#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo "- INFO: Reusing policies."
echo "- INFO: Drop database."
echo "- INFO: User [spark] shouldn't be able to drop database."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "drop database if exists $EXTERNAL_DB cascade")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [DROP] privilege on [$EXTERNAL_DB]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
