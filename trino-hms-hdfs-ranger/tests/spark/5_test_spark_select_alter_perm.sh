#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have [select, alter] access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT_ALTER"

# Wait 30 secs to make sure enough time has passed for the policies to get updated.
sleep 30

echo ""
echo "- INFO: [alter] should now succeed."

successMsg="org.apache.spark.sql.DataFrame = []"

retryOperationIfNeeded "alterSparkTable $SPARK_TABLE $NEW_SPARK_TABLE_NAME" "$successMsg" "false"
