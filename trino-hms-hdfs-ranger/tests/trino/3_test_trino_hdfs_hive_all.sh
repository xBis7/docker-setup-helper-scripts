#!/bin/bash

source "./testlib.sh"

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will now have all access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"

echo ""
echo "- INFO: Ranger policies updated."

successMsg="CREATE TABLE"

retryOperationIfNeeded "createTrinoTable $TRINO_TABLE $HDFS_DIR" "$successMsg" "false"
