#!/bin/bash

source "./testlib.sh"

set -e

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
command="insert into hive.default.$TRINO_TABLE values ('5', 'cat');"
expectedMsg="INSERT: 1 row"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"

echo ""
echo "- INFO: Delete from $TRINO_TABLE table."
echo "- INFO: [alter] should succeed but not delete itself because this table is not Hive managed."
command="delete from hive.default.$TRINO_TABLE;"
expectedMsg="Cannot delete from non-managed Hive table"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"

echo ""
echo "- INFO: Rename table $TRINO_TABLE."
echo "- INFO: [alter] should now succeed."

command="alter table hive.$DEFAULT_DB.$TRINO_TABLE rename to $NEW_TRINO_TABLE_NAME"
expectedMsg="RENAME TABLE"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"

echo ""
echo "- INFO: Insert into $TABLE_ANIMALS table."
echo "- INFO: [alter] should succeed."

command="insert into hive.default.$TABLE_ANIMALS values (1, 'cat');"
expectedMsg="INSERT: 1 row"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"

# FIXME: This test fails for Hive 4
# It fails with the following error: "Query 20240402_105548_00016_g47rj failed: Cannot delete from non-managed Hive table".
# It should not fail because $TABLE_ANIMALS is created in Hive managed space.
if [ "$HIVE_VERSION" != "4" ]; then
  echo ""
  echo "- INFO: Delete from $TABLE_ANIMALS table."
  echo "- INFO: [alter] should succeed."
  command="delete from hive.default.$TABLE_ANIMALS;"
  expectedMsg="DELETE"
  runTrino "trino" "$command" "shouldPass" "$expectedMsg"
fi
