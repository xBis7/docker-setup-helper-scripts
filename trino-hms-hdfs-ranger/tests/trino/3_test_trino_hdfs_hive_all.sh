#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [trino] will now have all access to HDFS."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Create $TABLE_ANIMALS table managed by Hive."
successMsg="CREATE TABLE"
cmd="create table hive.default.$TABLE_ANIMALS (id int, name varchar);"
retryOperationIfNeeded "$abs_path" "performTrinoCmd trino $cmd" "$successMsg" "false"

echo ""
echo "- INFO: Create $TRINO_TABLE table non-managed by Hive."
successMsg="CREATE TABLE"

retryOperationIfNeeded "$abs_path" "createTrinoTable $TRINO_TABLE $HDFS_DIR $DEFAULT_DB" "$successMsg" "false"
