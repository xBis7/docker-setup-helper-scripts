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

if createHdfsTestData "$HDFS_DIR"; then
  echo ""
  echo "- RESULT: HDFS test data creation succeeded."
else
  echo ""
  echo "- RESULT: HDFS test data creation failed."
fi

echo ""
if createTrinoDir; then
  echo "- INFO: Creation of HDFS dir for storing Trino data succeeded."
else
  echo "- INFO: Creation of HDFS dir for storing Trino data failed."
fi