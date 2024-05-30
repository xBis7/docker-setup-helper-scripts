#!/bin/bash

source "./ranger_api/lib.sh"

set -e

# This can be like this for multiple conditions:
# accesses1:users1/accesses2:users2/accesses3:users3
# If there is only 1 allow condition, then it will be just: accesses1:users1
policy_items=$1
request_type=$2
resources_url=${3:-"*"}

policy_name="all - url"
policy_uri_name="all%20-%20url"

json_payload+=$(cat <<EOF
{
EOF
)

if [ "$request_type" != "create" ]; then
  # Get the JSON response from the Ranger API.
  hivedev_res=$(getRangerPolicyJsonRes "$HIVE_RANGER_SERVICE" "$policy_uri_name")

  # Get the ID from the JSON response.
  id=$(getIdFromRangerPolicyJsonRes "$hivedev_res")

  # Get the GUID from the JSON response.
  guid=$(getGuidFromRangerPolicyJsonRes "$hivedev_res")

  json_payload+=$(cat <<EOF
    "id": $id,
    "guid": "$guid",
EOF
)
fi

url_values_array=$(getResourcesJsonArray "$resources_url")

policy_items_array=$(getPolicyItemsJsonArray "$policy_items")

json_payload+=$(cat <<EOF
  "isEnabled":true,
  "service":"$HIVE_RANGER_SERVICE",
  "name":"$policy_name",
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
  "denyPolicyItems":[
    
  ],
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
  createRangerPolicy "$json_payload"
else
  putUpdatedRangerPolicyJson "$json_payload" "$id"
fi
