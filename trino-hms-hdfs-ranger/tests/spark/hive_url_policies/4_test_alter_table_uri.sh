#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "Test4: ############### rename table location without and with Hive URL policies ###############"
echo ""

echo ""
echo "Creating the new URI."

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