#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "Test3: ############### create table (managed + not-managed) without and with Hive URL policies ###############"
echo ""

echo ""
echo "Adding user trino to the HDFS policies."

./ranger_api/create_update/create_update_hdfs_path_policy.sh "/*" "read,write,execute:hadoop,spark,postgres,trino" "put"

echo ""
echo "Deleting Hive URL policies."

./ranger_api/delete_policy.sh "hive" "url"
waitForPoliciesUpdate

echo ""
echo "##### Not - Managed Table #####"

echo ""
echo "- INFO: Trying to create not-managed table $GROSS_DB_NAME.$GROSS_TABLE_NAME."
echo "- INFO: [create] should fail."

op="WRITE"
if [ "$HIVE_VERSION" == "4" ]; then # TODO: investigate this.
  op="READ"
fi

failMsg="Permission denied: user [postgres] does not have [$op] privilege on [[hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR/$GROSS_TABLE_NAME, hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR/$GROSS_TABLE_NAME/]]"
cmd="create table hive.$GROSS_DB_NAME.$GROSS_TABLE_NAME (id int, name varchar);"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$failMsg" "true"

echo ""
echo "##### Managed Table #####"

# Goal of this test is to verify that user postgres can't create a table managed by Hive without Write permission for Hive URL policies.
# Ranger policies have two requirements
#   - user postgres must not have Write permission for Hive URL policy.
#   - user trino must have Write permission for HDFS policy.
# Important note is that it is not entirely clear why trino user needs mentioned permission. My assumption is that it is because of interference with other tests.
# It seems that Trino first checks for underlying HDFS permissions and then for Hive permissions. This is not the case with Spark.

op="WRITE"
if [ "$HIVE_VERSION" == "4" ]; then # TODO: investigate this.
  op="READ"
fi

echo ""
echo "- INFO: Trying to create managed table $TABLE_PERSONS."
echo "- INFO: [create] should fail."
failMsg="Permission denied: user [postgres] does not have [$op] privilege on [[hdfs://namenode/$HIVE_WAREHOUSE_DIR/$TABLE_PERSONS, hdfs://namenode/$HIVE_WAREHOUSE_DIR/$TABLE_PERSONS/]]"
cmd="create table hive.default.$TABLE_PERSONS (id int, name varchar);"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$failMsg" "true"

echo ""
echo "Creating Hive URL policies again."

./ranger_api/create_update/create_update_hive_url_policy.sh "read,write:postgres" "create"
waitForPoliciesUpdate

echo ""
echo "##### Not - Managed Table #####"

echo "- INFO: Creating not-managed table $GROSS_DB_NAME.$GROSS_TABLE_NAME."
echo "- INFO: [create] should succeed."
successMsg="CREATE TABLE"
cmd="create table hive.$GROSS_DB_NAME.$GROSS_TABLE_NAME (id int, name varchar);"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$successMsg" "false"

echo ""
echo "##### Managed Table #####"

echo "- INFO: Creating managed table $TABLE_PERSONS."
echo "- INFO: [create] should succeed."
successMsg="CREATE TABLE"
cmd="create table hive.default.$TABLE_PERSONS (id int, name varchar);"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$successMsg" "false"