#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2

# export IS_RESUME=

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true"
  createHdfsDir "$HIVE_WAREHOUSE_DIR"

  echo ""
  echo "- INFO: Updating Ranger policies. Loading base Hive URL policies. No user will have any access."
  ./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"

  waitForPoliciesUpdate

  createHdfsDir "$HIVE_GROSS_DB_TEST_DIR"
fi

updateHdfsPathPolicy "read,write,execute:hadoop,hive,spark,trino" "/*"
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:spark,hive,trino"
updateHiveDefaultDbPolicy "alter,create,drop,index,lock,select,update:spark,trino"
updateHiveUrlPolicy "read,write:spark,trino"

waitForPoliciesUpdate

docker exec -it "$TRINO_HOSTNAME" trino --execute="create schema hive.xbis_test with (location = 'hdfs://namenode/data/projects/test.db')"

# export IS_RESUME="true"

# docker restart $HMS_HOSTNAME

# # export IS_RESUME=

echo "create schema hive.xbis_test with (location = 'hdfs://namenode/data/projects/test.db');"
echo "./utils/connect_to_trino_shell.sh"
echo "drop schema hive.xbis_test;"

# ./utils/connect_to_trino_shell.sh
