#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

echo ""
echo "- INFO: Updating Ranger policies. User [spark] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: The user will also have 'select','read','create' Hive permissions."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive/select,read,create:spark,trino"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo "- INFO: Create database."
echo "- INFO: User [spark] should be able to create database."

command="spark.sql(\"create database $EXTERNAL_DB location 'hdfs://namenode/$HIVE_WAREHOUSE_DIR/$EXTERNAL_DB/external/$EXTERNAL_DB.db'\")"
runSpark "spark" "$command" "shouldPass"
