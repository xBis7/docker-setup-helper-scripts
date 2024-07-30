#!/bin/bash

source "./testlib.sh"

set -e

echo ""
echo "- INFO: To create an external schema and store it in HDFS, using Trino,"
echo "- INFO: all you need is HDFS perms. No Hive perms are needed."
echo "- INFO: User [trino] doesn't have HDFS or Hive permissions. The user will have only 'select' access."
echo "- INFO: Operation should fail."
echo ""

updateHdfsPathPolicy "/*" "read,write,execute:hadoop"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

command="create schema hive.$EXTERNAL_DB with (location = 'hdfs://namenode/$HIVE_WAREHOUSE_DIR/$EXTERNAL_DB/external/$EXTERNAL_DB.db')"
expectedMsg="Permission denied: user [trino] does not have [ALL] privilege on [hdfs://namenode/opt/hive/data/$EXTERNAL_DB/external/$EXTERNAL_DB.db]"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"
