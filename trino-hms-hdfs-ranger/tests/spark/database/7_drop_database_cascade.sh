#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: User [spark] has the correct HDFS and Hive permissions to drop a DB."
echo "- INFO: Dropping a DB that's not empty with CASCADE, should succeed."

successMsg="res0: org.apache.spark.sql.DataFrame = []"

retryOperationIfNeeded "$abs_path" "dropDatabaseWithSpark $EXTERNAL_DB true" "$successMsg" "false"
