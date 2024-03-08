#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: To create an external Database and store it in HDFS, using Spark,"
echo "- INFO: all you need is HDFS perms. No Hive perms are needed."
echo "- INFO: User [spark] doesn't have HDFS or Hive permissions."
echo "- INFO: Operation should fail."
echo ""

failMsg="Permission denied: user [spark] does not have [ALL] privilege on [hdfs://namenode/opt/hive/data/$EXTERNAL_DB/external/$EXTERNAL_DB.db]"

retryOperationIfNeeded "$abs_path" "createDatabaseWithSpark $EXTERNAL_DB" "$failMsg" "true"
