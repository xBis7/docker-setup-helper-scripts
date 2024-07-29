#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

# Load the default Ranger policies.
updateHdfsPathPolicy "/*" "read,write,execute:hadoop"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,read:spark"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Ranger policies updated."
echo ""

echo ""
echo "- INFO: HDFS user hadoop, should be able to create data with ranger default policies."
echo ""

setupHdfsPathsAndPermissions
