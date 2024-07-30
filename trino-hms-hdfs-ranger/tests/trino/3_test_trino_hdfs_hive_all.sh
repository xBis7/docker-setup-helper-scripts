#!/bin/bash

source "./testlib.sh"

set -e

echo ""
echo "- INFO: Updating Ranger policies. User [trino] will now have all access to HDFS."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Create $TABLE_ANIMALS table managed by Hive."
command="create table hive.default.$TABLE_ANIMALS (id int, name varchar);"
expectedMsg="CREATE TABLE"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"

echo ""
echo "- INFO: Create $TRINO_TABLE table non-managed by Hive."

command="create table hive.$DEFAULT_DB.$TRINO_TABLE (column1 varchar,column2 varchar) with (external_location = 'hdfs://namenode/$HDFS_DIR',format = 'CSV');"
expectedMsg="CREATE TABLE"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"
