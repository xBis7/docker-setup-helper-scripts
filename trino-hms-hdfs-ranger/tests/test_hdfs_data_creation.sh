#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

# Load the default Ranger policies.
updateHdfsPathPolicy "read,write,execute:hadoop" "/*"
updateHiveDbAllPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,read:spark"
updateHiveUrlPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Ranger policies updated."
echo ""

echo ""
echo "- INFO: HDFS user hadoop, should be able to create data with ranger default policies."
echo ""

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
