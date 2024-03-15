#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
component=$2
prepare_env=$3
stop_env=$4

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true"
fi

if [ "$component" == "spark" ]; then
  echo ""
  echo "### TEST_1 ###"
  ./tests/spark/hive_url_policies/1_test_no_hive_url_policies.sh "$abs_path"

  echo ""
  echo "### TEST_2 ###"
  ./tests/spark/hive_url_policies/2_test_create_hive_url_policies.sh "$abs_path"

else
  echo ""
    echo "### TEST_1 ###"
    ./tests/spark/hive_url_policies/1_test_no_hive_url_policies.sh "$abs_path"

    echo ""
    echo "### TEST_2 ###"
    ./tests/spark/hive_url_policies/2_test_create_hive_url_policies.sh "$abs_path"
fi

if [ "$stop_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
fi
