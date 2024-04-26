#!/bin/bash

# Goal of this test is to verify that user postgres can't create a table managed by Hive without Write permission for Hive URL policies.
# It consists of two parts - first part is to update Ranger policies and the second part is verifying that table creation failed.
# Ranger policies have two requirements
#   - user postgres must not have Write permission for Hive URL policy.
#   - user trino must have Write permission for HDFS policy.
# Important note is that it is not entirely clear why trino user needs mentioned permission. My assumption is that it is because of interference with other tests.
# It seems that Trino first checks for underlying HDFS permissions and then for Hive permissions. This is not the case with Spark.

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will not have Write permission for Hive URL policy"
./setup/load_ranger_policies.sh "$abs_path" "$TRINO_HDFS_AND_HIVE_ALL"
waitForPoliciesUpdate

op="WRITE"
if [ "$HIVE_VERSION" == "4" ]; then # TODO: investigate this.
  op="READ"
fi

echo ""
echo "- INFO: Create $TABLE_PERSONS table."
echo "- INFO: [create] should fail."
failMsg="Permission denied: user [postgres] does not have [$op] privilege on [[hdfs://namenode/$HIVE_WAREHOUSE_DIR/$TABLE_PERSONS, hdfs://namenode/$HIVE_WAREHOUSE_DIR/$TABLE_PERSONS/]]"
cmd="create table hive.default.$TABLE_PERSONS (id int, name varchar);"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$failMsg" "true"