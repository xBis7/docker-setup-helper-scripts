#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will now have all access to Hive $EXTERNAL_DB DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_EXT_DB_ALL"

echo ""
echo "- INFO: Ranger policies updated."

successMsg="CREATE TABLE"

retryOperationIfNeeded "$abs_path" "createTrinoTable $TRINO_TABLE $HDFS_DIR $EXTERNAL_DB" "$successMsg" "false"
