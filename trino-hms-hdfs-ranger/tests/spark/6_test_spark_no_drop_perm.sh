#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Reusing policies from previous test"

echo ""
echo "- INFO: [drop] should fail."

successMsg="Permission denied: user [spark] does not have [DROP] privilege on [default/$NEW_SPARK_TABLE_NAME]"

retryOperationIfNeeded "$abs_path" "dropSparkTable $NEW_SPARK_TABLE_NAME" "$successMsg" "false"
