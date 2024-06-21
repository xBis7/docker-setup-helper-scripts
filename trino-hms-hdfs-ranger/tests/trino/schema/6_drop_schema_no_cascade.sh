#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: User [trino] has the correct HDFS and Hive permissions to drop a DB."
echo "- INFO: Dropping a DB that's not empty, without using CASCADE, should fail."


failMsg="Cannot drop non-empty schema '$EXTERNAL_DB'"

retryOperationIfNeeded "$abs_path" "dropSchemaWithTrino $EXTERNAL_DB false" "$failMsg" "true"
