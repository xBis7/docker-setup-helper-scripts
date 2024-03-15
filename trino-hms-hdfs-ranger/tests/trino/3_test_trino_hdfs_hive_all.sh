#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will now have all access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"

# Wait 15 secs to make sure enough time has passed for the policies to get updated.
sleep 15

echo ""
echo "- INFO: Ranger policies updated."

echo ""
echo "- INFO: Create table from CSV file"
successMsg="CREATE TABLE"
retryOperationIfNeeded "$abs_path" "createTrinoTable $TRINO_TABLE $HDFS_DIR" "$successMsg" "false"

echo ""
echo "- INFO: Create table"
cmd="create table hive.default.$TABLE_SPORTS(id int, name varchar) with (external_location = 'hdfs://namenode:8020/$TRINO_DIR');"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$successMsg" "false"