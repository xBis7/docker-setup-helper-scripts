#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "Test3: ############### create table (managed + not-managed) without and with Hive URL policies ###############"
echo ""

echo ""
echo "Removing all Hive URL policies."

updateHdfsPathPolicy "read,write,execute:hadoop,spark,trino" "/*"
updateHiveDbAllPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy ""

waitForPoliciesUpdate

echo ""
echo "##### Not - Managed Table #####"

echo ""
echo "User 'spark' doesn't have access to create a table. Operation should fail."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
# If the command is
# spark.sql("CREATE TABLE gross_table (id INT, num INT) USING parquet LOCATION 'hdfs://namenode/opt/hive/data/gross_test/gross_test.db'")
#
# The expected exception is
# Permission denied: user [spark] does not have [WRITE] privilege on [[hdfs://namenode/opt/hive/data/gross_test/gross_test.db, hdfs://namenode/opt/hive/data/gross_test/gross_test.db/
#
# We get that exception along with another one
# Permission denied: user [spark] does not have [WRITE] privilege on [[hdfs://namenode/opt/hive/data/gross_test/gross_test.db/gross_test_table-__PLACEHOLDER__, hdfs://namenode/opt/hive/data/gross_test/gross_test.db/gross_test_table-__PLACEHOLDER__/]]
#
# The scala script reads only the second exception and the test fails.
# By specifying the external db and omitting the location, spark realizes that the table belongs to the external db and there is no issue.
scala_sql=$(base64encode "create table $GROSS_DB_NAME.$GROSS_TABLE_NAME (id INT, num INT)")
op="WRITE"
if [ "$HIVE_VERSION" == "4" ]; then # TODO: investigate this.
  op="READ"
fi
scala_msg=$(base64encode "Permission denied: user [spark] does not have [$op] privilege on [[hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR/$GROSS_TABLE_NAME, hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR/$GROSS_TABLE_NAME/")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "##### Managed Table #####"

echo ""
echo "- INFO: Create table."
echo "- INFO: User [spark] shouldn't be able to create table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "create table $TABLE_PERSONS (id int, name string)")

op="WRITE"
if [ "$HIVE_VERSION" == "4" ]; then # TODO: investigate this.
  op="READ"
fi

scala_msg=$(base64encode "Permission denied: user [spark] does not have [$op] privilege on [[hdfs://namenode/$HIVE_WAREHOUSE_DIR/$TABLE_PERSONS, hdfs://namenode/$HIVE_WAREHOUSE_DIR/$TABLE_PERSONS/]]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "Creating Hive URL policies again."

updateHdfsPathPolicy "read,write,execute:hadoop,spark,trino" "/*"
updateHiveDbAllPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy "read,write:spark"

waitForPoliciesUpdate

echo ""
echo "##### Not - Managed Table #####"

echo ""
echo "User 'spark' has access to create a table. Operation should succeed."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "create table $GROSS_DB_NAME.$GROSS_TABLE_NAME (id INT, num INT)")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "##### Managed Table #####"

echo ""
echo "- INFO: Create table."
echo "- INFO: User [spark] should be able to create table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "create table $TABLE_PERSONS (id int, name string)")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"
