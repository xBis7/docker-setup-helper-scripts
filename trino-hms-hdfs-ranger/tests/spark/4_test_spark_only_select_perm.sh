#!/bin/bash

source "./testlib.sh"

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have only [select] access to Hive default DB."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT"

# Wait 30 secs to make sure enough time has passed for the policies to get updated.
sleep 30

echo ""
echo "- INFO: [select] should succeed."

successMsg="|  1, dog|"

retryOperationIfNeeded "selectDataFromSparkTable $SPARK_TABLE" "$successMsg" "false"

# echo ""
# echo "- INFO: [alter] should fail."

# failMsg="Permission denied: user [spark] does not have [ALTER] privilege"

# retryOperationIfNeeded "alterSparkTable $SPARK_TABLE $NEW_SPARK_TABLE_NAME" "$failMsg" "true"
