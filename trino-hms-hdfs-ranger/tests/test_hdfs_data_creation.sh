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

createHdfsDir "$HDFS_DIR"
createHdfsFile "$HDFS_DIR"

createHdfsDir "$HIVE_WAREHOUSE_DIR"