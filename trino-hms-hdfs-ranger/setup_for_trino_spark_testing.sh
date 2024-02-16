#!/bin/bash

source "./testlib.sh"

abs_path=$1

./setup_docker_env.sh "$abs_path"

./start_docker_env.sh "$abs_path"

./load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"

if createHdfsTestData "$HDFS_DIR"; then
  echo ""
  echo "- RESULT: HDFS test data creation succeeded."
else
  echo ""
  echo "- RESULT: HDFS test data creation failed."

  ./retry_hdfs_setup_data_creation.sh
fi
