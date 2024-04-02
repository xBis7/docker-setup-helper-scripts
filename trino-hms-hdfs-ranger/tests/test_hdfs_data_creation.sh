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

notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "createHdfsDir $HDFS_DIR" "$notExpMsg" "false" "true"

notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "addHdfsTestFileUnderDir $HDFS_DIR" "$notExpMsg" "false" "true"

createHdfsDir "$HIVE_WAREHOUSE_DIR"
