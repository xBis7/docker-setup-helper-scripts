#!/bin/bash

source "./testlib.sh"

set -e

# Trino user is postgres.
echo "- INFO: Users need access to both the actual data and the metadata."
echo "- INFO: User 'spark' shouldn't be able to create a table without HDFS access."
echo "- INFO: All policies are to their defaults and Hive access to default DB has been removed for group public."
echo ""

# Failure due to lack of HDFS permissions.
failMsg='Permission denied: user=spark, access=WRITE, inode="/":hadoop:supergroup:drwxr-xr-x'

# We need to use single '' in the failMsg because it contains special characters e.g. /
# That way it will be interpreted as a string literal and won't be expanded.

retrySparkOperationIfNeeded "createSparkTable $SPARK_TABLE $HDFS_DIR" "$failMsg" "true"
