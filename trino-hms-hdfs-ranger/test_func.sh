#!/bin/bash

source "./testlib.sh"

failMsg="Permission denied: user [spark] does not have [ALTER] privilege on [default/$NEW_SPARK_TABLE_NAME]"

retryOperationIfNeeded "alterSparkTable $SPARK_TABLE $NEW_SPARK_TABLE_NAME" "$failMsg" "true"
