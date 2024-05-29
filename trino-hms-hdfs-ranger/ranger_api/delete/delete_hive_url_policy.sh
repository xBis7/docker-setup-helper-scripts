#!/bin/bash

source "./ranger_api/lib.sh"

set -e

# Provide a default value if not set.
policy_name=${1:-"all%20-%20url"}

# Get the JSON response from the Ranger API.
hivedev_res=$(getRangerPolicyJsonRes "$HIVE_RANGER_SERVICE" "$policy_name")

# Get the ID from the JSON response.
id=$(getIdFromRangerPolicyJsonRes "$hivedev_res")

echo ""
echo "Deleting Ranger policy with id: $id"
echo ""

deleteRangerPolicy "$id"
