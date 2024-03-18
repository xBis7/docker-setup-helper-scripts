#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [trino] will now have all access to HDFS."
./setup/load_ranger_policies.sh "$abs_path" "$TRINO_HDFS_AND_HIVE_ALL"
waitForPoliciesUpdate

echo ""
echo "- INFO: Create $TABLE_ANIMALS table managed by Hive."
successMsg="CREATE TABLE"
cmd="create table hive.default.$TABLE_ANIMALS (id int, name varchar);"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$successMsg" "false"

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will now have all access to Hive default DB."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"
waitForPoliciesUpdate

echo ""
echo "- INFO: Create $TRINO_TABLE table non-managed by Hive."
successMsg="CREATE TABLE"
retryOperationIfNeeded "$abs_path" "createTrinoTable $TRINO_TABLE $HDFS_DIR" "$successMsg" "false"
