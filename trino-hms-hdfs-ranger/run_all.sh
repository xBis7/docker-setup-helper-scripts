#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
github_user=$2
github_remote_user=$3
build_project=$4
java_8_home=$5

# Clone projects or just pull changes if projects exist.
./setup/get_or_update_projects.sh "$abs_path" "$github_user" "$github_remote_user"

# Build projects.
./setup/build_projects.sh "$abs_path" "$build_project" "$java_8_home"

# Copy jars and config files.
./setup/setup_docker_env.sh "$abs_path"

# Run the test scripts. Handling the docker env is configurable
# so that the user can run the tests in an already running env.
./tests/test_all.sh "$abs_path" "spark" "true"
./tests/test_all.sh "$abs_path" "trino" "true" "true"

createOrUpdateLastSuccessFile "$abs_path"
