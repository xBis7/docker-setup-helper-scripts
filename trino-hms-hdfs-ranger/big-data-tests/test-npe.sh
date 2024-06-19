#!/bin/bash

source "./big-data-tests/env_variables.sh"
source "./big-data-tests/lib.sh"

set -e

abs_path=$1
prepare_env=$2

export IS_RESUME=

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

updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$HIVE_USER,$SPARK_USER1" "/*"

# 1st parameter: permissions
# 2nd parameter: comma-separated list of DBs
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1,$HIVE_USER"

# 1st parameter: permissions
updateHiveDefaultDbPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1,$HIVE_USER"

# 1st parameter: permissions
# 2nd parameter: comma-separated list of URLs
updateHiveUrlPolicy "read,write:$SPARK_USER1,$HIVE_USER"

waitForPoliciesUpdate

docker exec -it "$TRINO_HOSTNAME" trino --execute="create schema hive.xbis_test with (location = 'hdfs://namenode/data/projects/test.db')"

# export IS_RESUME="true"

# docker restart $HMS_HOSTNAME

# # export IS_RESUME=

echo "drop schema hive.xbis_test;"

# ./utils/connect_to_trino_shell.sh

