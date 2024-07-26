#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

echo ""
echo "- INFO: Updating Ranger policies. User [trino] will now have all access to Hive $EXTERNAL_DB DB."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive,spark,trino"
updateHiveDefaultDbPolicy ""
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Ranger policies updated."

command="create table hive.$EXTERNAL_DB.$TRINO_TABLE (column1 varchar,column2 varchar) with (external_location = 'hdfs://namenode/$HDFS_DIR',format = 'CSV')"
expectedMsg="CREATE TABLE"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"
