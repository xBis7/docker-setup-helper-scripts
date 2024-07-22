#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

cleanup=$1

echo ""
echo "## Test Ranger KMS with encrypted disk data ##"
echo ""

updateKmsAllPolicy "*" "create,get,getkeys,delete:$HDFS_USER1"
waitForPoliciesUpdate

keyName="testKey"
dirName="encryptedDir"

if [ "$cleanup" == "true" ]; then
  expectedOutput="$keyName has been successfully deleted"
  runHdfsCmd "$HDFS_USER1" "hadoop key delete $keyName -f" "$expectedOutput"
fi

# Create key - success
expectedOutput="$keyName has been successfully created"
runHdfsCmd "$HDFS_USER1" "hadoop key create $keyName" "$expectedOutput"

# Create a directory that will be used for encryption.
runHdfsCmd "$HDFS_USER1" "hdfs dfs -mkdir -p /$dirName" "shouldBeEmpty"

# Set the directory as an encryption zone, that is encrypted with the created key.
expectedOutput="User:$HDFS_USER1 not allowed to do 'GET_METADATA' on '$keyName'"
runHdfsCmd "$HDFS_USER1" "hdfs crypto -createZone -keyName $keyName -path /$dirName" "$expectedOutput"

# Update access to provide 'getmetadata' access.
updateKmsAllPolicy "*" "create,get,getkeys,getmetadata,delete:$HDFS_USER1"
waitForPoliciesUpdate

expectedOutput="User:$HDFS_USER1 not allowed to do 'GENERATE_EEK' on '$keyName'"
runHdfsCmd "$HDFS_USER1" "hdfs crypto -createZone -keyName $keyName -path /$dirName" "$expectedOutput"

# Update access to provide 'generateeek' access.
updateKmsAllPolicy "*" "create,get,getkeys,getmetadata,generateeek,delete:$HDFS_USER1"
waitForPoliciesUpdate

# Success.
expectedOutput="Added encryption zone /$dirName"
runHdfsCmd "$HDFS_USER1" "hdfs crypto -createZone -keyName $keyName -path /$dirName" "$expectedOutput"

# List the encryption zones to make sure that it has been created.
runHdfsCmd "$HDFS_USER1" "hdfs crypto -listZones" "/$dirName  $keyName"

# Create a file and store it under the encrypted directory.
runHdfsCmd "$HDFS_USER1" "echo \"hi,test,file\" > /tmp/test.txt" "shouldBeEmpty"

expectedOutput="User:$HDFS_USER1 not allowed to do 'DECRYPT_EEK' on '$keyName'"
runHdfsCmd "$HDFS_USER1" "hdfs dfs -put /tmp/test.txt /$dirName" "$expectedOutput"

# Update access to provide 'decrypteek' access.
updateKmsAllPolicy "*" "create,get,getkeys,getmetadata,generateeek,decrypteek,delete:$HDFS_USER1"
waitForPoliciesUpdate

runHdfsCmd "$HDFS_USER1" "hdfs dfs -put /tmp/test.txt /$dirName" "shouldBeEmpty"

# Example of full cmd output:
# {
#   cipherSuite: {name: AES/CTR/NoPadding, algorithmBlockSize: 16}, 
#   cryptoProtocolVersion: CryptoProtocolVersion{description='Encryption zones', version=2, unknownValue=null}, 
#   edek: b63eb468622c69da4aa0f44107d27b5f, 
#   iv: 03911fb2aed597ec8fb43fe4e6c2bdb2, 
#   keyName: testKey, 
#   ezKeyVersionName: testKey@0
# }
# 
expectedOutput="keyName: $keyName, ezKeyVersionName: $keyName@0"
runHdfsCmd "$HDFS_USER1" "hdfs crypto -getFileEncryptionInfo -path /$dirName/test.txt" "$expectedOutput"

# When we try to read the file, it's automatically decrypted.
expectedOutput="hi,test,file"
runHdfsCmd "$HDFS_USER1" "hdfs dfs -cat /$dirName/test.txt" "$expectedOutput"

# Remove decryption access (decrypteek) to get an error.
updateKmsAllPolicy "*" "create,get,getkeys,getmetadata,generateeek,delete:$HDFS_USER1"
waitForPoliciesUpdate

expectedOutput="User:$HDFS_USER1 not allowed to do 'DECRYPT_EEK' on '$keyName'"
runHdfsCmd "$HDFS_USER1" "hdfs dfs -cat /$dirName/test.txt" "$expectedOutput"
