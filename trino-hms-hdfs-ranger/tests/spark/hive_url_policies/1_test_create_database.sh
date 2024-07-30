#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "Test1-spark: ############### create database without and with Hive URL policies ###############"
echo ""

echo ""
echo "Creating database $GROSS_DB_NAME as user 'spark' without Hive URL access. Operation should fail."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "create database $GROSS_DB_NAME location '/$HIVE_GROSS_DB_TEST_DIR'")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [WRITE] privilege on [[hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR, hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR/]]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "Updating Hive URL policies."
echo ""
updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark,trino"
updateHiveDbAllPolicy "*" "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy "*" "read,write:spark"

echo ""
echo "---------------------------------------------------"

waitForPoliciesUpdate

echo ""
echo "Creating database $GROSS_DB_NAME as user 'spark' with Hive URL access. Operation should succeed."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "create database $GROSS_DB_NAME location '/$HIVE_GROSS_DB_TEST_DIR'")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"
