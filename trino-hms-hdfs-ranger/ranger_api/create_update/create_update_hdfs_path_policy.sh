#!/bin/bash

source "./ranger_api/lib.sh"

set -e

resources_path=$1

# 'policy_items' can be like this for multiple conditions:
# accesses1:users1/accesses2:users2/accesses3:users3
# If there is only 1 allow condition, then it will be just: accesses1:users1
policy_items=$2
request_type=$3

json_payload+="{"

# If it's not a create request, then we need to include the id and the guid in the json.
if [ "$request_type" != "create" ]; then
  # Get the JSON response from the Ranger API.
  hadoopdev_res=$(getRangerPolicyJsonResponse "$HADOOP_RANGER_SERVICE" "$HDFS_ALL_POLICY_URI_NAME")

  # Get the ID from the JSON response.
  id=$(getIdFromRangerPolicyJsonResponse "$hadoopdev_res")

  # Get the GUID from the JSON response.
  guid=$(getGuidFromRangerPolicyJsonResponse "$hadoopdev_res")

  json_payload+=$(cat <<EOF
    "id": $id,
    "guid": $guid,
EOF
)
fi

resource_values_array=$(getJsonArrayFromCommaSeparatedList "$resources_path")

policy_items_array=$(getPolicyItemsJsonArray "$policy_items")

json_payload+=$(cat <<EOF
  "isEnabled": true,
  "service": "$HADOOP_RANGER_SERVICE",
  "name": "$HDFS_ALL_POLICY_NAME",
  "resources": {
    "path": {
      "values":$resource_values_array,
      "isExcludes": false,
      "isRecursive": true
    }
  },
  "policyItems":$policy_items_array,
  "serviceType": "hdfs",
  "isDenyAllElse": false,
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
  echo ""
  echo "-- Creating Ranger policy: hdfs / $HDFS_ALL_POLICY_NAME"

  createRangerPolicy "$json_payload"
else
  echo ""
  echo "-- Updating Ranger policy: hdfs / $HDFS_ALL_POLICY_NAME"

  putUpdatedRangerPolicyJson "$json_payload" "$id"
fi
