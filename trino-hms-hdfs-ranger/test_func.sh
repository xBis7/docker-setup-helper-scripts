#!/bin/bash

source "./testlib.sh"

failMsg="Permission denied: user [spark] does not have [CREATE] privilege on [default/$SPARK_TABLE]"

retryOperationIfNeeded "createSparkTable $SPARK_TABLE $HDFS_DIR" "$failMsg" "true"
