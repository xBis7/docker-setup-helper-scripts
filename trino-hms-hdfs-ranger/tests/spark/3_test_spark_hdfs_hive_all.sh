#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have all access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"

echo ""
echo "- INFO: Ranger policies updated."

echo ""
echo "- INFO: Create table"
echo "- INFO: [create] should succeed."
# It should only contain a WARN. Since we can't check that it only contains the WARN,
# then check that message doesn't contain Permission denied.
notExpMsg="Permission denied"

retryOperationIfNeeded "$abs_path" "createSparkTable $SPARK_TABLE $HDFS_DIR" "$notExpMsg" "false" "true"

echo ""
echo "- INFO: Create partitioned table"
echo "- INFO: [create] should succeed"
successMsg="org.apache.spark.sql.DataFrame = []"
sql="spark.sql(\\\"create table animals (id int, name string) using parquet partitioned by (name)\\\")"
retryOperationIfNeeded "$abs_path" "performSparkSql $sql" "$successMsg" "false"

echo ""
echo "- INFO: Add partition"
echo "- INFO: [alter] should succeed"
sql="spark.sql(\\\"alter table animals add partition (name='cow')\\\")"
retryOperationIfNeeded "$abs_path" "performSparkSql $sql" "$successMsg" "false"

echo ""
echo "- INFO: Create non partitioned table"
echo "- INFO: [create] should succeed"
successMsg="org.apache.spark.sql.DataFrame = []"
sql="spark.sql(\\\"create table sports (id int, name string)\\\")"
retryOperationIfNeeded "$abs_path" "performSparkSql $sql" "$successMsg" "false"

echo ""
echo "- INFO: Insert into table"
echo "- INFO: [alter] should succeed."
sql="spark.sql(\\\"insert into sports values(1, 'football')\\\")"
retryOperationIfNeeded "$abs_path" "performSparkSql $sql" "$successMsg" "false"