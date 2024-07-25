#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

echo ""
echo "Test1-trino: ############### create schema without and with Hive URL policies ###############"
echo ""

echo ""
echo "Creating schema $GROSS_DB_NAME as user 'trino' without Hive URL access. Operation should fail."

command="create schema hive.$GROSS_DB_NAME with (location = 'hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR')"
expectedMsg="Permission denied: user [trino] does not have [WRITE] privilege on [[hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR, hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR/]]"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"

verifyCreateWriteFailure "trino" "createDb" "$GROSS_DB_NAME"

echo ""
echo "Updating Hive URL policies."
echo ""
updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark,trino"
updateHiveDbAllPolicy "*" "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy "*" "read,write:trino"

echo ""
echo "---------------------------------------------------"

waitForPoliciesUpdate

echo ""
echo "Creating schema $GROSS_DB_NAME as user 'trino' with Hive URL access. Operation should succeed."

command="create schema hive.$GROSS_DB_NAME with (location = 'hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR')"
expectedMsg="CREATE SCHEMA"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"
