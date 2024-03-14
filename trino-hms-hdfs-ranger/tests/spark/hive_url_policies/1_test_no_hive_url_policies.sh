#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will not have Write permission for Hive URL policy"
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"

echo ""
echo "- INFO: Ranger policies updated."

echo ""
echo "- INFO: Create table"
echo "- INFO: [create] should fail."
failMsg="Permission denied: user [spark] does not have [WRITE] privilege on [[hdfs://namenode/opt/hive/data/sports, hdfs://namenode/opt/hive/data/sports/]]"
sql="spark.sql(\\\"create table sports (id int, name string)\\\")"
retryOperationIfNeeded "$abs_path" "performSparkSql $sql" "$failMsg" "true"