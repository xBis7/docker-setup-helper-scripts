#!/bin/bash

source "./ranger_api/lib.sh"

set -e

# It can be like this for multiple conditions:
# accesses1:users1/accesses2:users2/accesses3:users3
# If there is only 1 allow condition, then it will be just: accesses1:users1
policy_items=$1
request_type=$2
resources_url=${3:-"*"}
deny_policy_items=$4

json_payload+="{"

# If it's not a create request, then we need to include the id and the guid in the json.
if [ "$request_type" != "create" ]; then
  # Get the JSON response from the Ranger API.
  hivedev_res=$(getRangerPolicyJsonResponse "$HIVE_RANGER_SERVICE" "$HIVE_URL_POLICY_URI_NAME")

  # Get the ID from the JSON response.
  id=$(getIdFromRangerPolicyJsonResponse "$hivedev_res")

  # Get the GUID from the JSON response.
  guid=$(getGuidFromRangerPolicyJsonResponse "$hivedev_res")

  json_payload+=$(cat <<EOF
    "id": $id,
    "guid": $guid,
EOF
)
fi

url_values_array=$(getJsonArrayFromCommaSeparatedList "$resources_url")

policy_items_array="[]"
if [ "$policy_items" != "" ] && [ "$policy_items" != "-" ]; then
  policy_items_array=$(getPolicyItemsJsonArray "$policy_items")
fi

deny_policy_items_array="[]"
if [ "$deny_policy_items" != "" ]; then
  deny_policy_items_array=$(getPolicyItemsJsonArray "$deny_policy_items")
fi

json_payload+=$(cat <<EOF
  "isEnabled":true,
  "service":"$HIVE_RANGER_SERVICE",
  "name":"$HIVE_URL_POLICY_NAME",
  "isAuditEnabled":true,
  "resources":{
    "url":{
        "values":$url_values_array,
        "isExcludes":false,
        "isRecursive":true
    }
  },
  "policyItems":$policy_items_array,
  "serviceType":"hive",
  "isDenyAllElse":false,
  "denyPolicyItems":$deny_policy_items_array,
  "allowExceptions":[
    
  ],
  "denyExceptions":[
    
  ],
  "dataMaskPolicyItems":[
    
  ],
  "rowFilterPolicyItems":[
    
  ]
}
EOF
)

if [ "$request_type" == "create" ]; then
  echo ""
  echo "-- Creating Ranger policy: hive / $HIVE_URL_POLICY_NAME"

  createRangerPolicy "$json_payload"
else
  echo ""
  echo "-- Updating Ranger policy: hive / $HIVE_URL_POLICY_NAME"

  putUpdatedRangerPolicyJson "$json_payload" "$id"
fi
