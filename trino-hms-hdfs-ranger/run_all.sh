#!/bin/bash

source "./testlib.sh"

abs_path=$1
github_user=$2
github_remote_user=$3
build_starting_step=$4
java_8_home=$5

# Clone projects or just pull changes if projects exist.
./setup/get_or_update_projects.sh "$abs_path" "$github_user" "$github_remote_user"

# Build projects.
./setup/build_projects.sh "$abs_path" "$build_starting_step" "$java_8_home"

# Copy jars and config files.
./setup/setup_docker_env.sh "$abs_path"

# Run the test script. That script also starts the docker env 
# and stops it at the end or in any case of failure.
./tests/test_all.sh "$abs_path"

