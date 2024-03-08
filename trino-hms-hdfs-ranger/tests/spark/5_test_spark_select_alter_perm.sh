#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have [select, alter] access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT_ALTER"

# Wait 15 secs to make sure enough time has passed for the policies to get updated.
sleep 15

echo ""
echo "- INFO: [alter] should now succeed."

successMsg="org.apache.spark.sql.DataFrame = []"

retryOperationIfNeeded "$abs_path" "alterSparkTable $SPARK_TABLE $NEW_SPARK_TABLE_NAME" "$successMsg" "false"

# Drop partition
echo ""
echo "- INFO: [alter] should succeed."
sql="spark.sql(\\\"alter table animals drop partition (name='cow')\\\")"
retryOperationIfNeeded "$abs_path" "performSparkSql $sql" "$successMsg" "false"
