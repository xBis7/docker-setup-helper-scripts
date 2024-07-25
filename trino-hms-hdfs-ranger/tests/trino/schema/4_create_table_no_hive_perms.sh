#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: User [trino] has only 'select' Hive perms. Creating a table under db '$EXTERNAL_DB' should fail."
echo ""

# Failure due to lack of Hive metastore permissions.
updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive/select,read:spark,trino"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

command="create table hive.$EXTERNAL_DB.$TRINO_TABLE (column1 varchar,column2 varchar) with (external_location = 'hdfs://namenode/$HDFS_DIR',format = 'CSV')"
expectedMsg="Permission denied: user [trino] does not have [CREATE] privilege on [$EXTERNAL_DB/$TRINO_TABLE]"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"
