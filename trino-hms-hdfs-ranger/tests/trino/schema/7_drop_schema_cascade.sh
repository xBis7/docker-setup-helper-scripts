#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

updateHdfsPathPolicy "read,write,execute:hadoop,trino,spark" "/*"
updateHiveDbAllPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive,spark,trino"
updateHiveDefaultDbPolicy ""
updateHiveUrlPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: User [trino] has the correct HDFS and Hive permissions to drop a DB."
echo "- INFO: Dropping a DB that's not empty with CASCADE, should succeed."

successMsg="DROP SCHEMA"

retryOperationIfNeeded "$abs_path" "dropSchemaWithTrino $EXTERNAL_DB true" "$successMsg" "false"
