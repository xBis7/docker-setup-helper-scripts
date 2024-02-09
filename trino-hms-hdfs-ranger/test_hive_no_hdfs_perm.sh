#!/bin/bash

source "./testlib.sh"

# Trino user is postgres.
echo "Trino users need access to both the actual data and the metadata."
echo "Trino user postgres shouldn't be able to create a table without HDFS access."
echo ""

# Failure due to lack of HDFS permissions.
failMsg="Permission denied: user [postgres] does not have [ALL] privilege on [hdfs://namenode:8020/$hdfs_dir]"

retryOperationIfNeeded "createTrinoTable $TRINO_TABLE $HDFS_DIR" "$failMsg" "true"
