#!/bin/bash

source "./testlib.sh"

set -e

echo ""
echo "Test1-spark: ############### create database without and with Hive URL policies ###############"
echo ""

echo ""
echo "Creating database $GROSS_DB_NAME as user 'spark' without Hive URL access. Operation should fail."

command="spark.sql(\"create database $GROSS_DB_NAME location '/$HIVE_GROSS_DB_TEST_DIR'\")"
expectedMsg="Permission denied: user [spark] does not have [WRITE] privilege on [[hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR, hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR/]]"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"

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

command="spark.sql(\"create database $GROSS_DB_NAME location '/$HIVE_GROSS_DB_TEST_DIR'\")"
runSpark "spark" "$command" "shouldPass"
