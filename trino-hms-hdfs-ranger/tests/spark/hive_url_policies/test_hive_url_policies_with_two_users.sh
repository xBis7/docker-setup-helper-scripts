#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true"
  createHdfsDir "$HIVE_WAREHOUSE_DIR" # This isn't called with retryOperationIfNeeded and it won't print any descriptive output.
fi

echo ""
echo "- INFO: Updating Ranger policies. Loading base Hive URL policies. No user will have any access."
./setup/load_ranger_policies.sh "$abs_path" "$HIVE_URL_BASE_POLICIES"

# Create external DB directory 'gross_test.db'.
notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "createHdfsDir $HIVE_GROSS_DB_TEST_DIR" "$notExpMsg" "false" "true"

echo ""
echo "Updating HDFS policies."
echo ""
./ranger_api/create_update/create_update_hdfs_path_policy.sh "/*" "read,write,execute:hadoop,spark" "put"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive all db, cols, tables."
echo ""
./ranger_api/create_update/create_update_hive_all_db_policy.sh "select,update,create,drop,alter,index,lock:spark/select:games" "put"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive default db."
echo ""
./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "select,update,create,drop,alter,index,lock:spark/select:games" "put"

echo ""
echo "---------------------------------------------------"

waitForPoliciesUpdate

echo ""
echo "Section1: ############### create database without and with Hive URL policies ###############"
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
./ranger_api/create_update/create_update_hive_url_policy.sh "read,write:spark" "put"

echo ""
echo "---------------------------------------------------"

waitForPoliciesUpdate

echo ""
echo "Creating database $GROSS_DB_NAME as user 'spark' with Hive URL access. Operation should succeed."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "create database $GROSS_DB_NAME location '/$HIVE_GROSS_DB_TEST_DIR'")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "Section2: ############### test select and drop with user 'games' ###############"
echo ""

echo ""
echo "User 'games' has SELECT access. Show database should succeed."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "show databases")
scala_msg=$(base64encode "$GROSS_DB_NAME")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql $scala_msg games" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "Trying to drop database $GROSS_DB_NAME as user 'games'. User doesn't have permissions and operation should fail."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "drop database $GROSS_DB_NAME")
scala_msg=$(base64encode "Permission denied: user [games] does not have [DROP] privilege on [$GROSS_DB_NAME]")
# Add user 'games' as a parameter.
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg games" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "Section3: ############### create table without and with Hive URL policies ###############"
echo ""

echo ""
echo "Deleting Hive URL policies."

./ranger_api/delete_policy.sh "hive" "url"
waitForPoliciesUpdate

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
echo "Creating Hive URL policies again."

./ranger_api/create_update/create_update_hive_url_policy.sh "read,write:spark" "create"
waitForPoliciesUpdate

echo ""
echo "User 'spark' has access to create a table. Operation should succeed."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "create table $GROSS_DB_NAME.$GROSS_TABLE_NAME (id INT, num INT)")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "Section4: ############### rename table location without and with Hive URL policies ###############"
echo ""

echo ""
echo "Create the new URI."

# Create external DB directory 'gross_test2.db'.
notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "createHdfsDir $HIVE_GROSS_DB_TEST_DIR_SEC" "$notExpMsg" "false" "true"


echo ""
echo "Deleting Hive URL policies."

./ranger_api/delete_policy.sh "hive" "url"
waitForPoliciesUpdate

echo ""
echo "User 'spark' doesn't have access to move a table under a new URI. Operation should fail."

# For Hive URL policies to get invoked we need to rename the table URI.

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "alter table $GROSS_DB_NAME.$GROSS_TABLE_NAME set location '/$HIVE_GROSS_DB_TEST_DIR_SEC'")
op="WRITE"
if [ "$HIVE_VERSION" == "4" ]; then # TODO: investigate this.
  op="READ"
fi
scala_msg=$(base64encode "Permission denied: user [spark] does not have [$op] privilege on [[hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR_SEC, hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR_SEC/")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "Creating Hive URL policies again."

./ranger_api/create_update/create_update_hive_url_policy.sh "read,write:spark" "create"
waitForPoliciesUpdate

echo ""
echo "User 'spark' has access to move a table under a new URI. Operation should succeed."

cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "alter table $GROSS_DB_NAME.$GROSS_TABLE_NAME set location '/$HIVE_GROSS_DB_TEST_DIR_SEC'")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"
