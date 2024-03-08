#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: User [spark] has no Hive perms. Creating a table under db '$EXTERNAL_DB' should fail."
echo ""

# Failure due to lack of Hive metastore permissions.

failMsg="Permission denied: user [spark] does not have [CREATE] privilege on [$EXTERNAL_DB/$SPARK_TABLE]"

retryOperationIfNeeded "$abs_path" "createSparkTable $SPARK_TABLE $HDFS_DIR $EXTERNAL_DB" "$failMsg" "true"
