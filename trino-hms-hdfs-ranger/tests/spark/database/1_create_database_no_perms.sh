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
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(echo -n "create database poc_db location 'hdfs://namenode/opt/hive/data/poc_db/external/poc_db.db'" | base64)
scala_msg=$(echo -n "Permission denied: user [spark] does not have [ALL] privilege on [hdfs://namenode/opt/hive/data/poc_db/external/poc_db.db]" | base64)
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
