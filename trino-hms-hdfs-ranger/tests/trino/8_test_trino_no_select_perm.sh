#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] won't have any Hive privileges."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_ACCESS"
waitForPoliciesUpdate

echo ""
echo "- INFO: User [postgres] shouldn't be able to run select table."
failMsg="Permission denied: user [postgres] does not have [SELECT] privilege"
retryOperationIfNeeded "$abs_path" "selectDataFromTrinoTable $TABLE_ANIMALS $DEFAULT_DB" "$failMsg" "true"
