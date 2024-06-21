#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo "- INFO: Trino users need access to both the actual data and the metadata."
echo "- INFO: Trino user trino shouldn't be able to create a table without HDFS access."
echo "- INFO: All policies are to their defaults and Hive access to default DB has been removed for group public."
echo ""

# Failure due to lack of HDFS permissions.
failMsg="Permission denied: user [trino] does not have [ALL] privilege on" # [hdfs://namenode:8020/$HDFS_DIR]"

retryOperationIfNeeded "$abs_path" "createTrinoTable $TRINO_TABLE $HDFS_DIR $DEFAULT_DB" "$failMsg" "true"
