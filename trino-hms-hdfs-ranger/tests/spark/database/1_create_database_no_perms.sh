#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo "- INFO: Reusing policies."
echo "- INFO: To create an external Database and store it in HDFS, using Spark,"
echo "- INFO: all you need is HDFS perms. No Hive perms are needed."
echo "- INFO: User [spark] doesn't have HDFS or Hive permissions."
echo "- INFO: Create database."
echo "- INFO: User [spark] shouldn't be able to create database."

updateHdfsPathPolicy "read,write,execute:hadoop" "/*"
updateHiveDbAllPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "create database $EXTERNAL_DB location 'hdfs://namenode/opt/hive/data/$EXTERNAL_DB/external/$EXTERNAL_DB.db'")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [ALL] privilege on [hdfs://namenode/opt/hive/data/$EXTERNAL_DB/external/$EXTERNAL_DB.db]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
