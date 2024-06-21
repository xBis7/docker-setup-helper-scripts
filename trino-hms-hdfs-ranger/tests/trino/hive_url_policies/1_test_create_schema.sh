#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "Test1: ############### create schema without and with Hive URL policies ###############"
echo ""

echo ""
echo "Creating schema $GROSS_DB_NAME as user 'trino' without Hive URL access. Operation should fail."

failMsg="Permission denied: user [trino] does not have [WRITE] privilege on [[hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR, hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR/]]"
retryOperationIfNeeded "$abs_path" "createSchemaWithTrino $GROSS_DB_NAME $HIVE_GROSS_DB_TEST_DIR" "$failMsg" "true"

echo ""
echo "Updating Hive URL policies."
echo ""
updateHiveUrlPolicy "read,write:trino"

echo ""
echo "---------------------------------------------------"

waitForPoliciesUpdate

echo ""
echo "Creating schema $GROSS_DB_NAME as user 'trino' with Hive URL access. Operation should succeed."

successMsg="CREATE SCHEMA"
retryOperationIfNeeded "$abs_path" "createSchemaWithTrino $GROSS_DB_NAME $HIVE_GROSS_DB_TEST_DIR" "$successMsg" "false"
