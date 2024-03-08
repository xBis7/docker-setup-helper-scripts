#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: There will be no Hive permissions."

./setup/load_ranger_policies.sh "$abs_path" "$HDFS_ACCESS"

echo ""
echo "- INFO: Ranger policies updated."
echo ""

successMsg="res0: org.apache.spark.sql.DataFrame = []"

retryOperationIfNeeded "$abs_path" "createDatabaseWithSpark $EXTERNAL_DB" "$successMsg" "false"

