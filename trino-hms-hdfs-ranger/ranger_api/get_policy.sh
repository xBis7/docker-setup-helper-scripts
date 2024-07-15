#!/bin/bash

source "./ranger_api/lib.sh"

set -e

service=$1
policy=$2

# Parameter options:
# "hdfs" "all"
# "hdfs" "custom"
# "hive" "all_db"
# "hive" "defaultdb"
# "hive" "url"

# Get the JSON response from the Ranger API.
policy_res=$(getRangerPolicyJsonResponseUsingShortNames "$service" "$policy")

echo "$policy_res" | jq .

