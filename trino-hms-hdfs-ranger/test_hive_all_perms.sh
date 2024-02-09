#!/bin/bash

source "./testlib.sh"

abs_path=$1

echo ""
echo "Updating Ranger policies. User [postgres] will now have all access to Hive default DB."

./load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"

echo ""
echo "Ranger policies updated."

successMsg="CREATE TABLE"

retryOperationIfNeeded "createTrinoTable $trino_table $hdfs_dir" "$successMsg" "false"
