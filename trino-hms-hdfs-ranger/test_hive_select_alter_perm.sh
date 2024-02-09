#!/bin/bash

source "./testlib.sh"

abs_path=$1

echo ""
echo "Updating Ranger policies. User [postgres] will now have [select, alter] access to Hive default DB."

./load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT_ALTER"

echo ""
echo "Alter should now succeed."

successMsg="RENAME TABLE"

retryOperationIfNeeded "alterTrinoTable $TRINO_TABLE $NEW_TRINO_TABLE_NAME" "$successMsg" "false"
