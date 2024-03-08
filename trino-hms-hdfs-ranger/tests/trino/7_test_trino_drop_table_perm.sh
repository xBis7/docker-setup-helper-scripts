#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will now have [drop] access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT_ALTER_DROP"

echo ""
echo "- INFO: [drop] should succeed."

successMsg="DROP TABLE"

retryOperationIfNeeded "$abs_path" "dropTrinoTable $NEW_TRINO_TABLE_NAME" "$successMsg" "false"
