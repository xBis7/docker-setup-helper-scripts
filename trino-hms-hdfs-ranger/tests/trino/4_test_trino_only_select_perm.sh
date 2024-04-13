#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] will now have only [select] access to Hive default DB."
echo "- INFO: HDFS access for user [trino] has been removed."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT"
waitForPoliciesUpdate

echo ""
echo "- INFO: Select from $TRINO_TABLE table."
echo "- INFO: [select] should succeed."
successMsg="\"1\",\" dog\""

retryOperationIfNeeded "$abs_path" "selectDataFromTrinoTable $TRINO_TABLE $DEFAULT_DB" "$successMsg" "false"

# TODO: Cleanup this comment if the issue doesn't appear again.

# insert into, failed a few times with the wrong msg.
# Instead of "Permission denied: user=trino, access=WRITE, inode=\"/\":hadoop:supergroup:drwxr-xr-x"
# The msg was: "Query 20240413_112127_00087_uwcts failed: 
#               All operations other than the following update operations were completed: 
#               replace table parameters default.trino_test_table"
# In trino logs, there was this: "io.trino.event.QueryMonitor	TIMELINE: Query 20240413_112156_00088_uwcts :: FAILED (HIVE_FILESYSTEM_ERROR)"

echo ""
echo "- INFO: Insert into $TRINO_TABLE table."
echo "- INFO: [alter] should fail."
cmd="insert into hive.default.$TRINO_TABLE values ('5', 'cat');"
failMsg="Permission denied: user=trino, access=WRITE, inode=\"/\":hadoop:supergroup:drwxr-xr-x"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$failMsg" "true"

echo ""
echo "- INFO: Rename $TRINO_TABLE table."
echo "- INFO: [alter] should fail."
failMsg="Permission denied: user [postgres] does not have [ALTER] privilege"

retryOperationIfNeeded "$abs_path" "alterTrinoTable $TRINO_TABLE $NEW_TRINO_TABLE_NAME $DEFAULT_DB" "$failMsg" "true"

echo ""
echo "- INFO: Insert into $TABLE_ANIMALS table."
echo "- INFO: [alter] should fail."
cmd="insert into hive.default.$TABLE_ANIMALS values (1, 'cat');"
failMsg="Permission denied: user=trino, access=WRITE, inode=\"/\":hadoop:supergroup:drwxr-xr-x"
retryOperationIfNeeded "$abs_path" "performTrinoCmd $cmd" "$failMsg" "true"
