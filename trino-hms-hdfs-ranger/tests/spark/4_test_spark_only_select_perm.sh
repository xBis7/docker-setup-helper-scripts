#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have only [select] access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT"

# Wait 30 secs to make sure enough time has passed for the policies to get updated.
sleep 30

echo ""
echo "- INFO: [select] should succeed."

successMsg="|  1, dog|"

retryOperationIfNeeded "$abs_path" "selectDataFromSparkTable $SPARK_TABLE" "$successMsg" "false"

echo ""
echo "- INFO: [alter] should fail."

failMsg="Permission denied: user [spark] does not have [ALTER] privilege on [default/$SPARK_TABLE]"

retryOperationIfNeeded "$abs_path" "alterSparkTable $SPARK_TABLE $NEW_SPARK_TABLE_NAME" "$failMsg" "true"

# Drop partition
echo ""
echo "- INFO: [alter] should fail."
sql="spark.sql(\\\"alter table animals drop partition (name='cow')\\\")"
failMsg="Permission denied: user [spark] does not have [ALTER] privilege on [default/animals]"
retryOperationIfNeeded "$abs_path" "performSparkSql $sql" "$failMsg" "true"