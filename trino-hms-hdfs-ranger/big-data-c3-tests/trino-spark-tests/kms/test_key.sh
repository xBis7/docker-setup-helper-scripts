#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test Ranger KMS permissions with basic key operations ##"
echo ""

updateKmsAllPolicy ""
waitForPoliciesUpdate

# User doesn't have create permissions.
expectedOutput="AuthorizationException: User:$HDFS_USER1 not allowed to do 'CREATE_KEY' on 'key1'"
runHdfsCmd "$HDFS_USER1" "hadoop key create key1" "$expectedOutput"

updateKmsAllPolicy "*" "create:$HDFS_USER1"
waitForPoliciesUpdate

# Create - success
expectedOutput="key1 has been successfully created"
runHdfsCmd "$HDFS_USER1" "hadoop key create key1" "$expectedOutput"

# Get all - failure
expectedOutput="AuthorizationException: User:$HDFS_USER1 not allowed to do 'GET_KEYS'"
runHdfsCmd "$HDFS_USER1" "hadoop key list" "$expectedOutput"

# Delete - failure
expectedOutput="AuthorizationException: User:$HDFS_USER1 not allowed to do 'DELETE_KEY' on 'key1'"
runHdfsCmd "$HDFS_USER1" "hadoop key delete key1 -f" "$expectedOutput"

updateKmsAllPolicy "*" "create,getkeys:$HDFS_USER1"
waitForPoliciesUpdate

# Get all - success
expectedOutput="key1"
runHdfsCmd "$HDFS_USER1" "hadoop key list" "$expectedOutput"

updateKmsAllPolicy "*" "create,getkeys,delete:$HDFS_USER1"
waitForPoliciesUpdate

# Delete - success
expectedOutput="key1 has been successfully deleted"
runHdfsCmd "$HDFS_USER1" "hadoop key delete key1 -f" "$expectedOutput"

