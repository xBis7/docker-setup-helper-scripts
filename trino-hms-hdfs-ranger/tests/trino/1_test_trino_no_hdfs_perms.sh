#!/bin/bash

source "./testlib.sh"

set -e

updateHdfsPathPolicy "/*" "read,write,execute:hadoop"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,read:spark"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo "- INFO: Trino users need access to both the actual data and the metadata."
echo "- INFO: Trino user trino shouldn't be able to create a table without HDFS access."
echo "- INFO: All policies are to their defaults and Hive access to default DB has been removed for group public."
echo ""

command="create table hive.$DEFAULT_DB.$TRINO_TABLE (column1 varchar,column2 varchar) with (external_location = 'hdfs://namenode/$HDFS_DIR',format = 'CSV');"
# Failure due to lack of HDFS permissions.
expectedMsg="Permission denied: user [trino] does not have [ALL] privilege on" # [hdfs://namenode:8020/$HDFS_DIR]"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"
