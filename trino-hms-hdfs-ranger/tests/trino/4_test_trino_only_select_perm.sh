#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [trino] will now have only [select] access to Hive default DB."
echo "- INFO: HDFS access for user [trino] has been removed."

updateHdfsPathPolicy "read,write,execute:hadoop,spark" "/*"
updateHiveDbAllPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select:spark,trino"
updateHiveUrlPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Select from $TRINO_TABLE table."
echo "- INFO: [select] should succeed."
successMsg="\"1\",\" dog\""

retryOperationIfNeeded "$abs_path" "selectDataFromTrinoTable $TRINO_TABLE $DEFAULT_DB" "$successMsg" "false"

echo ""
echo "- INFO: Insert into $TRINO_TABLE table."
echo "- INFO: [alter] should fail."
cmd="insert into hive.default.$TRINO_TABLE values ('5', 'cat');"
failMsg="Permission denied: user=trino, access=WRITE, inode=\"/\":hadoop:supergroup:drwxr-xr-x"
retryOperationIfNeeded "$abs_path" "performTrinoCmd trino $cmd" "$failMsg" "true"

echo ""
echo "- INFO: Rename $TRINO_TABLE table."
echo "- INFO: [alter] should fail."
failMsg="Permission denied: user [trino] does not have [ALTER] privilege"

retryOperationIfNeeded "$abs_path" "alterTrinoTable $TRINO_TABLE $NEW_TRINO_TABLE_NAME $DEFAULT_DB" "$failMsg" "true"

echo ""
echo "- INFO: Insert into $TABLE_ANIMALS table."
echo "- INFO: [alter] should fail."
cmd="insert into hive.default.$TABLE_ANIMALS values (1, 'cat');"
failMsg="Permission denied: user=trino, access=WRITE, inode=\"/\":hadoop:supergroup:drwxr-xr-x"
retryOperationIfNeeded "$abs_path" "performTrinoCmd trino $cmd" "$failMsg" "true"
