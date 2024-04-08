#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1


echo ""
echo "- INFO: Reusing policies."
echo "- INFO: Drop database."
echo "- INFO: User [spark] shouldn't be able to drop non-empty database without 'cascade'."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "drop database if exists $EXTERNAL_DB")
# Error message for Spark 3.5.0: '[SCHEMA_NOT_EMPTY] Cannot drop a schema'
# Error message for Spark 3.3.2': 'Cannot drop a non-empty database: $EXTERNAL_DB. Use CASCADE option to drop a non-empty database.'
scala_msg=$(base64encode "Cannot drop a non-empty database: $EXTERNAL_DB. Use CASCADE option to drop a non-empty database.")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

