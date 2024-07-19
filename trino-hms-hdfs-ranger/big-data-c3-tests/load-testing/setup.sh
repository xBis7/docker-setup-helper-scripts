#!/bin/bash

source "./big-data-c3-tests/env_variables.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1

if [ "$CURRENT_ENV" == "local" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true" "4"
  createHdfsDir "$HIVE_WAREHOUSE_DIR"

  changeHdfsDirPermissions "$HIVE_WAREHOUSE_ROOT_DIR" 755
  changeHdfsDirPermissions "$HIVE_WAREHOUSE_PARENT_DIR" 755
  changeHdfsDirPermissions "$HIVE_WAREHOUSE_DIR" 755

  HIVE_BASE_POLICIES="hive_base_policies"

  echo ""
  echo "- INFO: Updating Ranger policies. Loading base Hive policies. No user will have any access."
  ./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"

  waitForPoliciesUpdate
fi

./big-data-c3-tests/load-testing/setup_policies.sh

# Copy all files under spark.
copyTestFilesUnderSpark "$abs_path" "true"

createSparkTableForTestingDdlOps "$SPARK_USER1"
