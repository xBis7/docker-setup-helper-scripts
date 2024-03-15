#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will now have only [select] access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT"

# Wait 15 secs to make sure enough time has passed for the policies to get updated.
sleep 15

echo ""
echo "- INFO: Select from table"
echo "- INFO: [select] should succeed."
successMsg="\"1\",\" dog\""
retryOperationIfNeeded "$abs_path" "selectDataFromTrinoTable $TRINO_TABLE" "$successMsg" "false"

echo ""
echo "- INFO: Rename table"
echo "- INFO: [alter] should fail."
failMsg="Permission denied: user [postgres] does not have [ALTER] privilege"
retryOperationIfNeeded "$abs_path" "alterTrinoTable $TRINO_TABLE $NEW_TRINO_TABLE_NAME" "$failMsg" "true"

echo ""
echo "- INFO: Insert into table"
echo "- INFO: [alter] should fail."
cmd="insert into hive.default.$TABLE_SPORTS values (1, 'football');"
failMsg="Permission denied: user=trino, access=WRITE, inode=\"/\":hadoop:supergroup:drwxr-xr-x"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$failMsg" "true"
