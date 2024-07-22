#!/bin/bash

source "./ranger_api/lib.sh"
source "./ranger_api/env_variables.sh"

set -e

request_type=$1

# accesses: 'create,delete,rollover,setkeymaterial,get,getkeys,getmetadata,generateeek,decrypteek'

# 'policy_items' can be like this for multiple conditions:
# accesses1:users1/accesses2:users2/accesses3:users3
# If there is only 1 allow condition, then it will be just: accesses1:users1
policy_items=$2
# In most tests we don't set any resources or deny_policies.
# Leave them as the last parameters so that they can easily be left empty.
resources_path=${3:-"*"}
deny_policy_items=$4

json_payload+="{"

# If it's not a create request, then we need to include the id and the guid in the json.
if [ "$request_type" != "create" ]; then
  # Get the JSON response from the Ranger API.
  kmsdev_res=$(getRangerPolicyJsonResponse "$KMS_RANGER_SERVICE" "$KEYNAME_POLICY_URI_NAME")

  # Get the ID from the JSON response.
  id=$(getIdFromRangerPolicyJsonResponse "$kmsdev_res")

  # Get the GUID from the JSON response.
  guid=$(getGuidFromRangerPolicyJsonResponse "$kmsdev_res")

  json_payload+=$(cat <<EOF
    "id": $id,
    "guid": $guid,
EOF
)
fi

resource_values_array=$(getJsonArrayFromCommaSeparatedList "$resources_path")

policy_items_array="[]"
if [ "$policy_items" != "" ] && [ "$policy_items" != "-" ]; then
  policy_items_array=$(getPolicyItemsJsonArray "$policy_items")
fi

deny_policy_items_array="[]"
if [ "$deny_policy_items" != "" ] && [ "$deny_policy_items" != "-" ]; then
  deny_policy_items_array=$(getPolicyItemsJsonArray "$deny_policy_items")
fi

json_payload+=$(cat <<EOF
  "isEnabled": true,
  "service": "$KMS_RANGER_SERVICE",
  "name": "$KEYNAME_POLICY_NAME",
  "resources": {
    "keyname": {
      "values":$resource_values_array,
      "isExcludes": false,
      "isRecursive": false
    }
  },
  "policyItems":$policy_items_array,
  "serviceType": "kms",
  "isDenyAllElse": false,
  "denyPolicyItems":$deny_policy_items_array
}
EOF
)

if [ "$request_type" == "create" ]; then
  echo ""
  echo "-- Creating Ranger policy: kms / $KEYNAME_POLICY_NAME"

  createRangerPolicy "$json_payload" "isKeyPolicy"
else
  echo ""
  echo "-- Updating Ranger policy: kms / $KEYNAME_POLICY_NAME"

  putUpdatedRangerPolicyJson "$json_payload" "$id" "isKeyPolicy"
fi

