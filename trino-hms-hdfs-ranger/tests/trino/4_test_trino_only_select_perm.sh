#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will now have only [select] access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT"

# Wait 30 secs to make sure enough time has passed for the policies to get updated.
sleep 30

echo ""
echo "- INFO: [select] should succeed."

successMsg="\"1\",\" dog\""

retryOperationIfNeeded "$abs_path" "selectDataFromTrinoTable $TRINO_TABLE" "$successMsg" "false"

echo ""
echo "- INFO: [alter] should fail."

failMsg="Permission denied: user [postgres] does not have [ALTER] privilege"

retryOperationIfNeeded "$abs_path" "alterTrinoTable $TRINO_TABLE $NEW_TRINO_TABLE_NAME" "$failMsg" "true"
