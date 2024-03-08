#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Reusing policies from previous test"

echo ""
echo "- INFO: [drop] should fail."

# We would expect this test to fail with the 'failMsg' but it fails with a diffrent error.
# 'Query 20240308_161853_00006_6nb76 failed: The following metastore delete operations failed: drop table default.new_trino_test_table'
failMsg="Permission denied: user [postgres] does not have [DROP] privilege on [default/$NEW_TRINO_TABLE_NAME]"

retryOperationIfNeeded "$abs_path" "dropTrinoTable $NEW_TRINO_TABLE_NAME" "$failMsg" "true"
