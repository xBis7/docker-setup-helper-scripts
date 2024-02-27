#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: No user will have permissions on Hive metastore operations on the default db."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_ACCESS"

echo ""
echo "- INFO: Ranger policies updated."

# Failure due to lack of Hive metastore permissions.

failMsg="Permission denied: user [spark] does not have [CREATE] privilege on [default/$SPARK_TABLE]"

retryOperationIfNeeded "$abs_path" "createSparkTable $SPARK_TABLE $HDFS_DIR" "$failMsg" "true"
