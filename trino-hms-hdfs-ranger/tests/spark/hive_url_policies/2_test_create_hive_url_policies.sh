#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will have Write permission for Hive URL policy"
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_AND_CREATE_HIVE_URL"

echo ""
echo "- INFO: Ranger policies updated."

echo ""
echo "- INFO: Create table"
echo "- INFO: [create] should not fail."
successMsg="org.apache.spark.sql.DataFrame = []"
sql="spark.sql(\\\"create table sports (id int, name string)\\\")"
retryOperationIfNeeded "$abs_path" "performSparkSql $sql" "$successMsg" "false"