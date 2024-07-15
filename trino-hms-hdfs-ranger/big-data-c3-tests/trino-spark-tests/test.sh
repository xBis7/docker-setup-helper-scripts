#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

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

# BigData note: Create the tmp directory and provide world access to it so that Trino can use it.
createHdfsDir "tmp"
changeHdfsDirPermissions "tmp" 777

# ./big-data-c3-tests/trino-spark-tests/spark/test_spark.sh "$abs_path"

# # Cleanup any data leftovers from the spark tests.
# ./big-data-c3-tests/trino-spark-tests/trino/cleanup.sh

# ./big-data-c3-tests/trino-spark-tests/trino/test_trino.sh "$abs_path"

# ./big-data-c3-tests/trino-spark-tests/trino/test_10_copy.sh "$prepare_env"

./big-data-c3-tests/copy_files_under_spark.sh "$abs_path"

# ./big-data-c3-tests/trino-spark-tests/spark/test_11_copy.sh "$prepare_env" "false" "true"

./big-data-c3-tests/trino-spark-tests/spark/insert_into.sh "$prepare_env"
