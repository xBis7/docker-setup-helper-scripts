#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Reusing policies."
echo "- INFO: Drop table."
echo "- INFO: User [spark] shouldn't be able to drop table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "drop table $DEFAULT_DB.$NEW_SPARK_TABLE_NAME")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [DROP] privilege on [$DEFAULT_DB/$NEW_SPARK_TABLE_NAME]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
