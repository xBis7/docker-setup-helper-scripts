#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

./docker/stop_docker_env.sh "$abs_path"

./setup/setup_docker_env.sh "$abs_path"

./docker/start_docker_env.sh "$abs_path"

./big-data-c3-tests/copy_files_under_spark.sh "$abs_path"

./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"

waitForPoliciesUpdate

setupHdfsPathsAndPermissions
