#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies."
echo "- INFO: Users [trino] will now have [select, alter] access to Hive default DB."
echo "- INFO: User [trino] will now have [Write] permission for HDFS policy."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,Alter:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Insert into $TRINO_TABLE table."
echo "- INFO: [alter] should succeed."
cmd="insert into hive.default.$TRINO_TABLE values ('5', 'cat');"
successMsg="INSERT: 1 row"
retryOperationIfNeeded "$abs_path" "performTrinoCmd trino $cmd" "$successMsg" "false"

echo ""
echo "- INFO: Delete from $TRINO_TABLE table."
echo "- INFO: [alter] should succeed but not delete itself because this table is not Hive managed."
cmd="delete from hive.default.$TRINO_TABLE;"
failMsg="Cannot delete from non-managed Hive table"
retryOperationIfNeeded "$abs_path" "performTrinoCmd trino $cmd" "$failMsg" "true"

echo ""
echo "- INFO: Rename table $TRINO_TABLE."
echo "- INFO: [alter] should now succeed."
successMsg="RENAME TABLE"

retryOperationIfNeeded "$abs_path" "alterTrinoTable $TRINO_TABLE $NEW_TRINO_TABLE_NAME $DEFAULT_DB" "$successMsg" "false"

echo ""
echo "- INFO: Insert into $TABLE_ANIMALS table."
echo "- INFO: [alter] should succeed."
cmd="insert into hive.default.$TABLE_ANIMALS values (1, 'cat');"
successMsg="INSERT: 1 row"
retryOperationIfNeeded "$abs_path" "performTrinoCmd trino $cmd" "$successMsg" "false"

# FIXME: This test fails for Hive 4
# It fails with the following error: "Query 20240402_105548_00016_g47rj failed: Cannot delete from non-managed Hive table".
# It should not fail because $TABLE_ANIMALS is created in Hive managed space.
if [ "$HIVE_VERSION" != "4" ]; then
  echo ""
  echo "- INFO: Delete from $TABLE_ANIMALS table."
  echo "- INFO: [alter] should succeed."
  cmd="delete from hive.default.$TABLE_ANIMALS;"
  successMsg="DELETE"
  retryOperationIfNeeded "$abs_path" "performTrinoCmd trino $cmd" "$successMsg" "false"
fi
