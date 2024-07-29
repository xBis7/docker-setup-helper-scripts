#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

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

  setupHdfsPathsAndPermissions
fi

echo ""
echo "- INFO: Updating Ranger policies. Loading base policies. No user will have any access."
./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"

waitForPoliciesUpdate

# Create external DB directory 'gross_test.db'.
createHdfsDir "$HIVE_GROSS_DB_TEST_DIR"

echo ""
echo "Updating HDFS policies."
echo ""
updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark,trino"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive all db, cols, tables."
echo ""
updateHiveDbAllPolicy "*" "select,update,create,drop,alter,index,lock:spark,trino/select:games"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive default db."
echo ""
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive URL policies."
echo ""
updateHiveUrlPolicy ""

echo ""
echo "---------------------------------------------------"

waitForPoliciesUpdate
