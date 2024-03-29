#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

./setup/setup_for_trino_spark_testing.sh "$abs_path"

echo ""
echo "- INFO: Updating Ranger policies. Users [spark/postgres] will now have all access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"

# It should only contain a WARN. Since we can't check that it only contains the WARN,
# then check that message doesn't contain Permission denied.
sparkNotExpMsg="Permission denied"

retryOperationIfNeeded "$abs_path" "createSparkTable $SPARK_TABLE $HDFS_DIR $DEFAULT_DB" "$sparkNotExpMsg" "false" "true"

trinoSuccessMsg="CREATE TABLE"

retryOperationIfNeeded "$abs_path" "createTrinoTable $TRINO_TABLE $HDFS_DIR $DEFAULT_DB" "$successMsg" "false"
