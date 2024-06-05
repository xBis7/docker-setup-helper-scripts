#!/bin/bash

source "./ranger_api/lib.sh"

set -e

service=$1
policy=$2

# Get the JSON response from the Ranger API.
policy_res=$(getRangerPolicyJsonResponseUsingShortNames "$service" "$policy")

# Get the ID from the JSON response.
id=$(getIdFromRangerPolicyJsonResponse "$policy_res")

echo ""
echo "-- Deleting Ranger policy with id: $id"

deleteRangerPolicy "$id"
