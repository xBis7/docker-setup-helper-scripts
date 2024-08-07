#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
component=$2
prepare_env=$3
stop_env=$4

if [[ ("$component" != "spark") && ("$component" != "trino") ]]; then
  echo "Unknown component, exiting..."
  echo "Try one of the following: 'spark', 'trino'"
  exit 1
fi

./tests/hive_url_policies_env_setup.sh "$abs_path" "$prepare_env"

# Don't pass the "$prepare_env" variable because we have already setup the env.
./tests/"$component"/hive_url_policies/test.sh "$abs_path"

if [ "$stop_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
fi
