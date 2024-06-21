#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: User [trino] has no Hive perms. Creating a table under db '$EXTERNAL_DB' should fail."
echo ""

# Failure due to lack of Hive metastore permissions.
updateHiveDbAllPolicy "select,read:spark,trino"
waitForPoliciesUpdate

failMsg="Permission denied: user [trino] does not have [CREATE] privilege on [$EXTERNAL_DB/$TRINO_TABLE]"

retryOperationIfNeeded "$abs_path" "createTrinoTable $TRINO_TABLE $HDFS_DIR $EXTERNAL_DB" "$failMsg" "true"
