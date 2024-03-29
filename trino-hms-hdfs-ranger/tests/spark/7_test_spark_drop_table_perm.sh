#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have [drop] access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT_ALTER_DROP"

echo ""
echo "- INFO: [drop] should succeed."

successMsg="org.apache.spark.sql.DataFrame = []"

retryOperationIfNeeded "$abs_path" "dropSparkTable $NEW_SPARK_TABLE_NAME $DEFAULT_DB" "$successMsg" "false"
