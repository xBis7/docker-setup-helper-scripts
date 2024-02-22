#!/bin/bash

source "./testlib.sh"

abs_path=$1

./docker/stop_docker_env.sh "$abs_path"

./setup/setup_docker_env.sh "$abs_path"

./docker/start_docker_env.sh "$abs_path"

# This dump is 
# "$HDFS_AND_HIVE_ALL" + some very limited for URL based auth in Hive.
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_LIMITED_SPARK_URL"

if createHdfsTestData "$HDFS_DIR"; then
  echo ""
  echo "- RESULT: HDFS test data creation succeeded."
else
  echo ""
  echo "- RESULT: HDFS test data creation failed."
fi
