#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: User [postgres] has the correct HDFS and Hive permissions to drop a DB."
echo "- INFO: Dropping a DB that's not empty with CASCADE, should succeed."

successMsg="DROP SCHEMA"

retryOperationIfNeeded "$abs_path" "dropSchemaWithTrino $EXTERNAL_DB true" "$successMsg" "false"
