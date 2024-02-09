#!/bin/bash

source "./testlib.sh"

abs_path=$1

echo ""
echo "Updating Ranger policies. User [postgres] will now have only [select] access to Hive default DB."

./load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT"

echo ""
echo "Select should succeed."

sucessMsg="                                   column1                                   | column2 "

retryOperationIfNeeded "selectDataFromTrinoTable $TRINO_TABLE" "$successMsg" "false"

echo ""
echo "Alter should fail."

failMsg="Permission denied: user [postgres] does not have [ALTER] privilege"

retryOperationIfNeeded "alterTrinoTable $TRINO_TABLE $NEW_TRINO_TABLE_NAME" "$failMsg" "true"
