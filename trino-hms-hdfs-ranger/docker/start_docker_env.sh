#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
hive_url_policies_enabled=$2
workers_num=$3

# copyKerberosFilesUnderRanger() {

# }

if ! docker network ls | grep rangernw; then
  docker network create rangernw
fi

# This will start kdc and generate the keytabs.
"$abs_path"/"$CURRENT_REPO"/compose/kerberos/create_keytabs.sh "$abs_path"

# Wait 10 seconds.
sleep 10

# Copy krb5.conf under ranger
# Copy keytabs under ranger

handleRangerEnv "$abs_path" "start"

# Start the rest of the env. The keytabs will be available and each setup will be able to mount them.
handleHadoopEnv "$abs_path" "start"

# handleHiveEnv "$abs_path" "start" "$hive_url_policies_enabled"

# handleTrinoEnv "$abs_path" "start"

# handleSparkEnv "$abs_path" "start" "$workers_num"
