#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have all access to Hive $EXTERNAL_DB DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_EXT_DB_ALL"

echo ""
echo "- INFO: Ranger policies updated."

# It should only contain a WARN. Since we can't check that it only contains the WARN,
# then check that message doesn't contain Permission denied.
notExpMsg="Permission denied"

retryOperationIfNeeded "$abs_path" "createSparkTable $SPARK_TABLE $HDFS_DIR $EXTERNAL_DB" "$notExpMsg" "false" "true"
