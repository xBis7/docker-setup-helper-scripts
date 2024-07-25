#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1

echo ""
echo "Test3-trino: ############### create table (managed + not-managed) without and with Hive URL policies ###############"
echo ""

echo ""
echo "Removing all Hive URL policies."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark,trino"
updateHiveDbAllPolicy "*" "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy ""

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

command="create table hive.$GROSS_DB_NAME.$GROSS_TABLE_NAME (id int, name varchar);"
expectedMsg="Permission denied: user [trino] does not have [$op] privilege on [[hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR/$GROSS_TABLE_NAME, hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR/$GROSS_TABLE_NAME/]]"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"

echo ""
echo "##### Managed Table #####"

# Goal of this test is to verify that user trino can't create a table managed by Hive without Write permission for Hive URL policies.
# Ranger policies have two requirements
#   - user trino must not have Write permission for Hive URL policy.
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

command="create table hive.default.$TABLE_PERSONS (id int, name varchar);"
expectedMsg="Permission denied: user [trino] does not have [$op] privilege on [[hdfs://namenode/$HIVE_WAREHOUSE_DIR/$TABLE_PERSONS, hdfs://namenode/$HIVE_WAREHOUSE_DIR/$TABLE_PERSONS/]]"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"

echo ""
echo "Creating Hive URL policies again."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark,trino"
updateHiveDbAllPolicy "*" "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy "*" "read,write:trino"

waitForPoliciesUpdate

echo ""
echo "##### Not - Managed Table #####"

echo "- INFO: Creating not-managed table $GROSS_DB_NAME.$GROSS_TABLE_NAME."
echo "- INFO: [create] should succeed."

command="create table hive.$GROSS_DB_NAME.$GROSS_TABLE_NAME (id int, name varchar);"
expectedMsg="CREATE TABLE"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"

echo ""
echo "##### Managed Table #####"

echo "- INFO: Creating managed table $TABLE_PERSONS."
echo "- INFO: [create] should succeed."

command="create table hive.default.$TABLE_PERSONS (id int, name varchar);"
expectedMsg="CREATE TABLE"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"
