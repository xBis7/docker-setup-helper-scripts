#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

# Load the default Ranger policies.
./setup/load_ranger_policies.sh "$abs_path" "$DEFAULT_AND_NO_HIVE"

echo ""
echo "- INFO: Ranger policies updated."
echo ""

# Extend to test with HDFS policies??
echo ""
echo "- INFO: HDFS user hadoop, should be able to create data with ranger default policies."
echo ""

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
