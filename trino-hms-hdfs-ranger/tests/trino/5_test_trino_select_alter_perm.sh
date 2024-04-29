#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies."
echo "- INFO: Users [postgres] will now have [select, alter] access to Hive default DB."
echo "- INFO: User [trino] will now have [Write] permission for HDFS policy."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT_ALTER"
waitForPoliciesUpdate

echo ""
echo "- INFO: Insert into $TRINO_TABLE table."
echo "- INFO: [alter] should succeed."
cmd="insert into hive.default.$TRINO_TABLE values ('5', 'cat');"
successMsg="INSERT: 1 row"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$successMsg" "false"

echo ""
echo "- INFO: Delete from $TRINO_TABLE table."
echo "- INFO: [alter] should succeed but not delete itself because this table is not Hive managed."
cmd="delete from hive.default.$TRINO_TABLE;"
failMsg="Cannot delete from non-managed Hive table"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$failMsg" "true"

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
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$successMsg" "false"

# This was failing for Spark-Hive4. Adding the property below in the hive-site.xml fixed it.
#   <property>
#     <name>metastore.metadata.transformer.class</name>
#     <value> </value>
#   </property>

# Simple 'CREATE TABLE' commands should create a managed table but for Hive4 that's not the case.
# 'DESCRIBE FORMATTED table' is showing 'Table Properties -> TRANSLATED_TO_EXTERNAL'
# and the table is treated as if it is non-managed.

# That unexpected behavior is caused by the transformer according to these references
# and the current workaround is to disable it.
# Check ticket description: https://issues.apache.org/jira/browse/HIVE-24954
# Check ticket comments: https://issues.apache.org/jira/browse/HIVE-28198
echo ""
echo "- INFO: Delete from $TABLE_ANIMALS table."
echo "- INFO: [alter] should succeed."
cmd="delete from hive.default.$TABLE_ANIMALS;"
successMsg="DELETE"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$successMsg" "false"
