#!/bin/bash

source "./testlib.sh"

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: No user will have permissions on Hive metastore operations on the default db."

./load_ranger_policies.sh "$abs_path" "$HDFS_ACCESS"

echo ""
echo "- INFO: Ranger policies updated."

# Failure due to lack of Hive metastore permissions.

failMsg="Permission denied: user [postgres] does not have [CREATE] privilege on"

retryOperationIfNeeded "createTrinoTable $TRINO_TABLE $HDFS_DIR" "$failMsg" "true"