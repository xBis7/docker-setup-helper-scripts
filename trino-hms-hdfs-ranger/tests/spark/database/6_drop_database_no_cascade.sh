#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: User [spark] has the correct HDFS and Hive permissions to drop a DB."
echo "- INFO: Dropping a DB that's not empty, without using CASCADE, should fail."


failMsg="[SCHEMA_NOT_EMPTY] Cannot drop a schema"

retryOperationIfNeeded "$abs_path" "dropDatabaseWithSpark $EXTERNAL_DB" "$failMsg" "true"
