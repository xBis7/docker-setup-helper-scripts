#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have only [select] access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT"

# Wait 15 secs to make sure enough time has passed for the policies to get updated.
sleep 15

echo ""
echo "- INFO: Select from table"
echo "- INFO: [select] should succeed."

successMsg="|  1, dog|"

retryOperationIfNeeded "$abs_path" "selectDataFromSparkTable $SPARK_TABLE $DEFAULT_DB" "$successMsg" "false"

echo ""
echo "- INFO: Rename table"
echo "- INFO: [alter] should fail."

failMsg="Permission denied: user [spark] does not have [ALTER] privilege on [default/$SPARK_TABLE]"

retryOperationIfNeeded "$abs_path" "alterSparkTable $SPARK_TABLE $NEW_SPARK_TABLE_NAME $DEFAULT_DB" "$failMsg" "true"

echo ""
echo "- INFO: Drop partition"
echo "- INFO: [alter] should fail."
sql="spark.sql(\\\"alter table $TABLE_ANIMALS drop partition (name='cow')\\\")"
failMsg="Permission denied: user [spark] does not have [ALTER] privilege on [default/$TABLE_ANIMALS]"
retryOperationIfNeeded "$abs_path" "performSparkSql $sql" "$failMsg" "true"

echo ""
echo "- INFO: Insert into table"
echo "- INFO: [alter] should fail."
sql="spark.sql(\\\"insert into $TABLE_SPORTS values(1, 'football')\\\")"
failMsg="Permission denied: user [spark] does not have [ALTER] privilege on [default/$TABLE_SPORTS]"
retryOperationIfNeeded "$abs_path" "performSparkSql $sql" "$failMsg" "true"

echo ""
echo "- INFO: Truncate table"
echo "- INFO: [alter] should fail."
sql="spark.sql(\\\"truncate table $TABLE_SPORTS\\\")"
retryOperationIfNeeded "$abs_path" "performSparkSql $sql" "$failMsg" "true"