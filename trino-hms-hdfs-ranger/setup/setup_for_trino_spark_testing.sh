#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

./docker/stop_docker_env.sh "$abs_path"

./setup/setup_docker_env.sh "$abs_path"

./docker/start_docker_env.sh "$abs_path"

./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"

waitForPoliciesUpdate

notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "createHdfsDir $HDFS_DIR" "$notExpMsg" "false" "true"

notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "createHdfsFile $HDFS_DIR" "$notExpMsg" "false" "true"

notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "createHdfsDir $HIVE_WAREHOUSE_DIR" "$notExpMsg" "false" "true"

changeHdfsPathPermissions "$HDFS_DIR" 755
changeHdfsPathPermissions "$HDFS_DIR/test.csv" 655
changeHdfsPathPermissions "$HIVE_WAREHOUSE_ROOT_DIR" 755
changeHdfsPathPermissions "$HIVE_WAREHOUSE_PARENT_DIR" 755
changeHdfsPathPermissions "$HIVE_WAREHOUSE_DIR" 755
