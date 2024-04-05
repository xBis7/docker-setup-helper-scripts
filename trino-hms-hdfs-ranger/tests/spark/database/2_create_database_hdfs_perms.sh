#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: There will be no Hive permissions."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_ACCESS"
waitForPoliciesUpdate

echo "- INFO: Create database."
echo "- INFO: User [spark] should be able to create database."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(echo -n "create database poc_db location 'hdfs://namenode/opt/hive/data/poc_db/external/poc_db.db'" | base64)
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"
