#!/bin/bash

source "./testlib.sh"

abs_path=$1

./setup/setup_for_trino_spark_testing.sh "$abs_path"

successMsg="CREATE TABLE"

retryOperationIfNeeded "createTrinoTable $TRINO_TABLE $HDFS_DIR" "$successMsg" "false"
