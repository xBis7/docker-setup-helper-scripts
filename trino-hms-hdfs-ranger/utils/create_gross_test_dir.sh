#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "createHdfsDir $HIVE_GROSS_TEST_DIR" "$notExpMsg" "false" "true"
