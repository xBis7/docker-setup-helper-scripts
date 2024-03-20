#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: User [spark] has the correct HDFS and Hive permissions to drop a DB."
echo "- INFO: Dropping a DB that's not empty, without using CASCADE, should fail."


# This is error message for Spark 3.5.0
# failMsg="[SCHEMA_NOT_EMPTY] Cannot drop a schema"

# This is error message for Spark 3.3.2
failMsg="Cannot drop a non-empty database: $EXTERNAL_DB. Use CASCADE option to drop a non-empty database."

retryOperationIfNeeded "$abs_path" "dropDatabaseWithSpark $EXTERNAL_DB" "$failMsg" "true"
