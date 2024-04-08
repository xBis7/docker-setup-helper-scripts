#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have all access to Hive default DB."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"
waitForPoliciesUpdate

echo ""
echo "- INFO: Create table."
echo "- INFO: User [spark] should be able to create table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_EXTERNAL_TABLE_CREATION_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "$DEFAULT_DB.$SPARK_TABLE")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_EXTERNAL_TABLE_CREATION_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Create partitioned table."
echo "- INFO: User [spark] should be able to create table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "create table $TABLE_ANIMALS (id int, name string) using parquet partitioned by (name)")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Add partition."
echo "- INFO: User [spark] should be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "alter table $TABLE_ANIMALS add partition (name='cow')")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Create non partitioned table."
echo "- INFO: User [spark] should be able to create table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "create table $TABLE_SPORTS (id int, name string)")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Insert into table."
echo "- INFO: User [spark] should be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "insert into $TABLE_SPORTS values(1, 'football')")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"
