#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2

# This script sets up the environment and the correct policies needed by
# the Hive URL policies tests. It's placed here because it's used by both
# Spark and Trino tests.

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true"
  createHdfsDir "$HIVE_WAREHOUSE_DIR" # This isn't called with retryOperationIfNeeded and it won't print any descriptive output.
fi

echo ""
echo "- INFO: Updating Ranger policies. Loading base Hive URL policies. No user will have any access."
./setup/load_ranger_policies.sh "$abs_path" "$HIVE_URL_BASE_POLICIES"

# Create external DB directory 'gross_test.db'.
notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "createHdfsDir $HIVE_GROSS_DB_TEST_DIR" "$notExpMsg" "false" "true"

echo ""
echo "Updating HDFS policies."
echo ""
./ranger_api/create_update/create_update_hdfs_path_policy.sh "/*" "read,write,execute:hadoop,spark,postgres" "put"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive all db, cols, tables."
echo ""
./ranger_api/create_update/create_update_hive_all_db_policy.sh "select,update,create,drop,alter,index,lock:spark,postgres/select:games" "put"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive default db."
echo ""
./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "select,update,create,drop,alter,index,lock:spark,postgres/select:games" "put"

echo ""
echo "---------------------------------------------------"

waitForPoliciesUpdate
