#!/bin/bash

# For this test, prerequisite is that 3_test_trino_hdfs_hive_all.sh is run.

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will now have only [select] access to Hive default DB."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT"
waitForPoliciesUpdate

echo ""
echo "- INFO: Select from $TRINO_TABLE table."
echo "- INFO: [select] should succeed."
successMsg="\"1\",\" dog\""
retryOperationIfNeeded "$abs_path" "selectDataFromTrinoTable $TRINO_TABLE" "$successMsg" "false"

echo ""
echo "- INFO: Insert into $TRINO_TABLE table."
echo "- INFO: [alter] should fail."
cmd="insert into hive.default.$TRINO_TABLE values ('5', 'cat');"
failMsg="Permission denied: user=trino, access=WRITE, inode=\"/\":hadoop:supergroup:drwxr-xr-x"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$failMsg" "true"

echo ""
echo "- INFO: Rename $TRINO_TABLE table."
echo "- INFO: [alter] should fail."
failMsg="Permission denied: user [postgres] does not have [ALTER] privilege"
retryOperationIfNeeded "$abs_path" "alterTrinoTable $TRINO_TABLE $NEW_TRINO_TABLE_NAME" "$failMsg" "true"

echo ""
echo "- INFO: Insert into $TABLE_ANIMALS table."
echo "- INFO: [alter] should fail."
cmd="insert into hive.default.$TABLE_ANIMALS values (1, 'cat');"
failMsg="Permission denied: user=trino, access=WRITE, inode=\"/\":hadoop:supergroup:drwxr-xr-x"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$failMsg" "true"