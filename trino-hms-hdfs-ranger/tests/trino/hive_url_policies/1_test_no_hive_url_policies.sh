#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will not have Write permission for Hive URL policy"
./setup/load_ranger_policies.sh "$abs_path" "$TRINO_HDFS_AND_HIVE_ALL"
waitForPoliciesUpdate

echo ""
echo "- INFO: Create $TABLE_PERSONS table."
echo "- INFO: [create] should fail."
failMsg="Permission denied: user [postgres] does not have [WRITE] privilege on [[hdfs://namenode/$HIVE_WAREHOUSE_DIR/$TABLE_PERSONS, hdfs://namenode/$HIVE_WAREHOUSE_DIR/$TABLE_PERSONS/]]"
cmd="create table hive.default.$TABLE_PERSONS (id int, name varchar);"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$failMsg" "true"