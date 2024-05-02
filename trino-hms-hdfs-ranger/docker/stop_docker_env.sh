#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

# All environments are using Ranger's network.
# Ranger was started first but now we need to stop it
# last so that the network will be properly removed.

handleApacheDsEnv "$abs_path" "stop"

handleTrinoEnv "$abs_path" "stop"

handleSparkEnv "$abs_path" "stop"

handleHiveEnv "$abs_path" "stop"

handleHadoopEnv "$abs_path" "stop"

handleRangerEnv "$abs_path" "stop"
