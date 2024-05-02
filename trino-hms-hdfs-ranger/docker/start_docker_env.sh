#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
hive_url_policies_enabled=$2

# All environments are using Ranger's network. Ranger needs to start first.

handleRangerEnv "$abs_path" "start"

handleHadoopEnv "$abs_path" "start"

handleHiveEnv "$abs_path" "start" "$hive_url_policies_enabled"

handleTrinoEnv "$abs_path" "start"

handleSparkEnv "$abs_path" "start"

handleApacheDsEnv "$abs_path" "start"
