#!/bin/bash

source "./testlib.sh"

abs_path=$1

./setup/setup_docker_env.sh "$abs_path"

./docker/start_docker_env.sh "$abs_path"

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"

if createHdfsTestData "$HDFS_DIR"; then
  echo ""
  echo "- RESULT: HDFS test data creation succeeded."
else
  echo ""
  echo "- RESULT: HDFS test data creation failed."

  ./setup/retry_hdfs_setup_data_creation.sh
fi

./docker/start_docker_containers.sh "$abs_path" "hms"
