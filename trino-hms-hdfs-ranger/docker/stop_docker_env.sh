#!/bin/bash

source "./testlib.sh"

abs_path=$1

# We need to stop the docker environments in reverse order, 
# from the one we used to start them.

# This needs to be done, so that all docker networks will be properly removed.

# We need to stop Hive and Trino before Hadoop and Hadoop before Ranger.
# The order will be
# 1. Trino
# 2. Hive
# 3. Hadoop
# 4. Ranger

handleTrinoSparkEnv "$abs_path" "stop"

handleHiveEnv "$abs_path" "stop"

handleHadoopEnv "$abs_path" "stop"

handleRangerEnv "$abs_path" "stop"



