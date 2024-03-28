#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

./docker/stop_docker_env.sh "$abs_path"

./setup/setup_docker_env.sh "$abs_path"

./docker/start_docker_env.sh "$abs_path"

# This dump is 
# "$HDFS_AND_HIVE_ALL" + some very limited for URL based auth in Hive.
./setup/load_ranger_policies.sh "$abs_path" "$DEFAULT_AND_NO_HIVE"

createHdfsDir "$HDFS_DIR"
createHdfsFile "$HDFS_DIR"

createHdfsDir "$HIVE_WAREHOUSE_DIR"
