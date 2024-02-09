#!/bin/bash

source "./testlib.sh"

abs_path=$1

# Load the default Ranger policies.
./load_ranger_policies.sh "$abs_path" "$DEFAULT_AND_NO_HIVE"
echo "Ranger policies updated."

# Extend to test with HDFS policies??
echo "HDFS user hadoop, should be able to create data with ranger default policies."
if createHdfsTestData "$HDFS_DIR"; then
  echo "HDFS test data creation succeeded."
else
  echo "HDFS test data creation failed."
fi
