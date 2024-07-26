#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
hive_url_policies_enabled=$2
workers_num=$3

# All environments are using Ranger's network. Ranger needs to start first.

# if docker network create shared-network; then
#   echo "Creating 'shared-network' succeeded."
# else
#   echo "Creating 'shared-network' failed."
#   echo "Retry manually by running: "
#   echo "> docker network create shared-network"
# fi

handleRangerEnv "$abs_path" "start"

# handleKerberosEnv "$abs_path" "start"

# This will start kdc and generate the keytabs.
"$abs_path"/"$CURRENT_REPO"/compose/kerberos/create_keytabs.sh "$abs_path"

# Wait 10 seconds.
sleep 10

# Start the rest of the env. The keytabs will be available and each setup will be able to mount them.
handleHadoopEnv "$abs_path" "start"

# handleHiveEnv "$abs_path" "start" "$hive_url_policies_enabled"

# handleTrinoEnv "$abs_path" "start"

# handleSparkEnv "$abs_path" "start" "$workers_num"
