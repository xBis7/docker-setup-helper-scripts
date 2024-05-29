#!/bin/bash

source "./ranger_api/lib.sh"

set -e

policy_name="all%20-%20path"

# Get the JSON response from the Ranger API.
hadoopdev_res=$(getRangerPolicyJsonRes "$HADOOP_RANGER_SERVICE" "$policy_name")

# Get the ID from the JSON response.
id=$(getIdFromRangerPolicyJsonRes "$hadoopdev_res")

echo ""
echo "Deleting Ranger policy with id: $id"
echo ""

deleteRangerPolicy "$id"
