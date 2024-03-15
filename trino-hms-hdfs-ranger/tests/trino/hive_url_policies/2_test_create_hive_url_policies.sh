#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will have Write permission for Hive URL policy"
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_AND_CREATE_HIVE_URL"

echo ""
echo "- INFO: Ranger policies updated."

echo "- INFO: Create table"
echo "- INFO: [create] should succeed."
successMsg="CREATE TABLE"
cmd="create table hive.default.$TABLE_PERSONS(id int, name varchar) with (external_location = 'hdfs://namenode:8020/$TRINO_DIR');"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$successMsg" "false"