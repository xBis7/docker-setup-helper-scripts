#!/bin/bash

source "./testlib.sh"

set -e

echo ""
echo "Test4-spark: ############### rename table location without and with Hive URL policies ###############"
echo ""

echo ""
echo "Creating the new URI."

# Create external DB directory 'gross_test2.db'.
createHdfsDir "$HIVE_GROSS_DB_TEST_DIR_SEC"

echo ""
echo "Removing all Hive URL policies."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark,trino"
updateHiveDbAllPolicy "*" "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy ""

waitForPoliciesUpdate

echo ""
echo "User 'spark' doesn't have access to move a table under a new URI. Operation should fail."

# For Hive URL policies to get invoked we need to rename the table URI.
command="spark.sql(\"alter table $GROSS_DB_NAME.$GROSS_TABLE_NAME set location '/$HIVE_GROSS_DB_TEST_DIR_SEC'\")"

op="WRITE"
if [ "$HIVE_VERSION" == "4" ]; then # TODO: investigate this.
  op="READ"
fi
expectedMsg="Permission denied: user [spark] does not have [$op] privilege on [[hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR_SEC, hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR_SEC/"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"

echo ""
echo "Creating Hive URL policies again."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark,trino"
updateHiveDbAllPolicy "*" "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy "*" "read,write:spark"

waitForPoliciesUpdate

echo ""
echo "User 'spark' has access to move a table under a new URI. Operation should succeed."

command="spark.sql(\"alter table $GROSS_DB_NAME.$GROSS_TABLE_NAME set location '/$HIVE_GROSS_DB_TEST_DIR_SEC'\")"
runSpark "spark" "$command" "shouldPass"
