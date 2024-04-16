#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path"
fi

# Load Ranger policies.
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_POLICIES_FOR_RANGER_TESTING"

echo ""
echo "- INFO: Ranger policies updated."
echo ""

sleep 10

dir1="test1"
dir2="test2"
user="games"

echo ""
echo "- INFO: This test is for making sure that HDFS is properly set up and working with Ranger policies."
echo "- INFO: Users [hadoop, $user] will have all access on /$dir1 but only [hadoop] will have access on /$dir2."
echo "- INFO: User [hadoop] will create both directories." 
echo "- INFO: We will test that user [$user] will be able to put a file under /$dir1 but not under /$dir2."
echo ""

notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "createHdfsDir $dir1" "$notExpMsg" "false" "true"

notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "createHdfsDir $dir2" "$notExpMsg" "false" "true"

notExpMsg="Permission denied"
retryOperationIfNeeded "$abs_path" "createHdfsFileAsUser $user $dir1" "$notExpMsg" "false" "true"

failMsg="Permission denied: user=games, access=WRITE,"
retryOperationIfNeeded "$abs_path" "createHdfsFileAsUser $user $dir2" "$failMsg" "true"

