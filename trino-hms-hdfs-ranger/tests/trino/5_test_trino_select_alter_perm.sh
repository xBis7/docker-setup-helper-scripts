#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will now have [select, alter] access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT_ALTER"

# Wait 15 secs to make sure enough time has passed for the policies to get updated.
sleep 15

echo ""
echo "- INFO: Rename table"
echo "- INFO: [alter] should now succeed."
successMsg="RENAME TABLE"
retryOperationIfNeeded "$abs_path" "alterTrinoTable $TRINO_TABLE $NEW_TRINO_TABLE_NAME" "$successMsg" "false"

echo ""
echo "- INFO: Insert into table"
echo "- INFO: [alter] should succeed."
cmd="insert into hive.default.$TABLE_SPORTS values (1, 'football');"
successMsg="INSERT: 1 row"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$successMsg" "false"