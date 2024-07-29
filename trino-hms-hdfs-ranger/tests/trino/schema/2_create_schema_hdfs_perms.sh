#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

echo ""
echo "- INFO: Updating Ranger policies. User [trino] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: The user will also have 'select','read','create' Hive permissions."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive/select,read,create:spark,trino"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Ranger policies updated."
echo ""

command="create schema hive.$EXTERNAL_DB with (location = 'hdfs://namenode/$HIVE_WAREHOUSE_DIR/$EXTERNAL_DB/external/$EXTERNAL_DB.db')"
expectedMsg="CREATE SCHEMA"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"
