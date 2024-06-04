#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2

if [ "$prepare_env" == "true" ]; then
./docker/stop_docker_env.sh "$abs_path"
./setup/setup_docker_env.sh "$abs_path"
./docker/start_docker_env.sh "$abs_path" "true"
createHdfsDir "$HIVE_WAREHOUSE_DIR"
fi

./tests/trino/hive_url_policies/1_test_no_hive_url_policies.sh "$abs_path"

./tests/trino/hive_url_policies/2_test_create_hive_url_policies.sh "$abs_path"
