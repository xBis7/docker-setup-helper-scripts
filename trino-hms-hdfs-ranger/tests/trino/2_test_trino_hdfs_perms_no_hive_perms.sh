#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: No user will have permissions on Hive metastore operations on the default db."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_ACCESS"

echo ""
echo "- INFO: This test is run after the schema tests." 
echo "- INFO: The previous policies allow a user to create a table."
echo "- INFO: Wait 30 secs, to make sure policy updates have been picked up."
echo ""
# This test is flaky because policies do not get updated fast enough and table is created on the first run (before retry mechanism kicks in).
# Because of that sleep time is increased to 30 seconds. It might be a good idea to do the same for other tests where wait time is necessary.
sleep 30

echo ""
echo "- INFO: Ranger policies updated."

# Failure due to lack of Hive metastore permissions.

failMsg="Permission denied: user [postgres] does not have [CREATE] privilege on"

retryOperationIfNeeded "$abs_path" "createTrinoTable $TRINO_TABLE $HDFS_DIR $DEFAULT_DB" "$failMsg" "true"
