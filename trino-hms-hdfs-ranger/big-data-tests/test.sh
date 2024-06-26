#!/bin/bash

source "./big-data-tests/env_variables.sh"
source "./big-data-tests/lib.sh"

set -e

abs_path=$1
prepare_env=$2

if [ "$CURRENT_ENV" == "local" ] && [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true"
  createHdfsDir "$HIVE_WAREHOUSE_DIR"

  HIVE_BASE_POLICIES="hive_base_policies"

  echo ""
  echo "- INFO: Updating Ranger policies. Loading base Hive URL policies. No user will have any access."
  ./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"
fi

# createHdfsDir uses the '-p' option. If the directory already exists, there won't be an error.
createHdfsDir "$HIVE_GROSS_DB_TEST_DIR"

# ./big-data-tests/spark/test_spark.sh "$abs_path"

./big-data-tests/trino/test_trino.sh
