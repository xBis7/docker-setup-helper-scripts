#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1


echo ""
echo "- INFO: Reusing policies."
echo "- INFO: Drop database."
echo "- INFO: User [spark] shouldn't be able to drop non-empty database without 'cascade'."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(echo -n "drop database if exists poc_db" | base64)
scala_msg=$(echo -n "Cannot drop a non-empty database: poc_db. Use CASCADE option to drop a non-empty database." | base64)
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

