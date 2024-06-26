#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [trino] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: The user will also have 'select','read','create' Hive permissions."

updateHdfsPathPolicy "read,write,execute:hadoop,trino,spark" "/*"
updateHiveDbAllPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive/select,read,create:spark,trino"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Ranger policies updated."
echo ""

successMsg="CREATE SCHEMA"

retryOperationIfNeeded "$abs_path" "createSchemaWithTrino $EXTERNAL_DB" "$successMsg" "false"

