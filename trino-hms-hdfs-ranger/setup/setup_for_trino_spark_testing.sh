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

# Print cmd first.
createHdfsDir "$HDFS_DIR" "true"

if createHdfsDir "$HDFS_DIR"; then
  # Print cmd first.
  addHdfsTestFileUnderDir "$HDFS_DIR" "true"
  if addHdfsTestFileUnderDir "$HDFS_DIR"; then
    echo ""
    echo "- RESULT: HDFS test data creation succeeded."
  else
    echo ""
    echo "- RESULT: HDFS test data creation failed."
  fi
else
  echo ""
  echo "- RESULT: HDFS test data creation failed."
fi

createHdfsDir "$HIVE_WAREHOUSE_DIR"
