#!/bin/bash

source "./big-data-tests/env_variables.sh"
source "./big-data-tests/lib.sh"

set -e

abs_path=$1
prepare_env=$2

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true"
  createHdfsDir "$HIVE_WAREHOUSE_DIR"
fi

HIVE_URL_BASE_POLICIES="hive_url_base_policies"

echo ""
echo "- INFO: Updating Ranger policies. Loading base Hive URL policies. No user will have any access."
./setup/load_ranger_policies.sh "$abs_path" "$HIVE_URL_BASE_POLICIES"

createHdfsDir "$HIVE_GROSS_DB_TEST_DIR"

./big-data-tests/spark/test_spark.sh "$abs_path"
