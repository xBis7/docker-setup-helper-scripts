#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: User [postgres] has HDFS permissions but no Hive permissions."
echo "- INFO: Dropping a database should fail."
echo ""

failMsg="Permission denied: user [postgres] does not have [DROP] privilege on [$EXTERNAL_DB]"

retryOperationIfNeeded "$abs_path" "dropSchemaWithTrino $EXTERNAL_DB false" "$failMsg" "true"


