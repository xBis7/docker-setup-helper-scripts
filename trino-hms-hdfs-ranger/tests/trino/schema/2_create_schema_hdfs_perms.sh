#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [postgres] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: There will be no Hive permissions."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_ACCESS"
waitForPoliciesUpdate

echo ""
echo "- INFO: Ranger policies updated."
echo ""

successMsg="CREATE SCHEMA"

retryOperationIfNeeded "$abs_path" "createSchemaWithTrino $EXTERNAL_DB" "$successMsg" "false"

