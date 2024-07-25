#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1

echo "- INFO: To create an external Database and store it in HDFS, using Spark,"
echo "- INFO: all you need is HDFS perms. No Hive perms are needed."
echo "- INFO: User [spark] doesn't have HDFS permissions. The user will have only 'select' access."
echo "- INFO: Create database."
echo "- INFO: User [spark] shouldn't be able to create database."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

command="spark.sql(\"create database $EXTERNAL_DB location 'hdfs://namenode/opt/hive/data/$EXTERNAL_DB/external/$EXTERNAL_DB.db'\")"
expectedMsg="Permission denied: user [spark] does not have [ALL] privilege on [hdfs://namenode/opt/hive/data/$EXTERNAL_DB/external/$EXTERNAL_DB.db]"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"
