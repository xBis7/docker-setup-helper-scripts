#!/bin/bash

source "./testlib.sh"

abs_path=$1

# Clone projects or just pull changes if projects exist.
./get_or_update_projects.sh "$abs_path"

# Build projects.
./build_projects.sh "$abs_path"

# Copy jars and config files.
./setup_docker_env.sh "$abs_path"

# Start docker env.
./start_docker_env.sh "$abs_path"

