#!/bin/bash

source "./ranger_api/lib.sh"

set -e

resources_path=$1
accesses=$2
users=$3

policy_name="all%20-%20path"

# Get the JSON response from the Ranger API.
hadoopdev_res=$(getRangerPolicyJsonRes "$HADOOP_RANGER_SERVICE" "$policy_name")

# Get the ID from the JSON response.
id=$(getIdFromRangerPolicyJsonRes "$hadoopdev_res")

# Get the GUID from the JSON response.
guid=$(getGuidFromRangerPolicyJsonRes "$hadoopdev_res")

echo ""
echo "id: $id"
echo "guid: $guid"
echo ""

resource_values_array=$(getResourcesJsonArray "$resources_path")

accesses_array=$(getAccessesJsonArray "$accesses")

echo ""
echo "accesses_array:"
echo "$accesses_array"

users_array=$(getUsersJsonArray "$users")

echo ""
echo "users array:"
echo "$users_array"

json_payload=$(cat <<EOF
{
  "id": $id,
  "guid": "$guid",
  "isEnabled": true,
  "service": "$HADOOP_RANGER_SERVICE",
  "name": "all - path",
  "resources": {
    "path": {
      "values":$resource_values_array,
      "isExcludes": false,
      "isRecursive": true
    }
  },
  "policyItems": [
    {
      "accesses":$accesses_array,
      "users":$users_array,
      "delegateAdmin": true
    }
  ],
  "serviceType": "hdfs",
  "isDenyAllElse": false
}
EOF
)

putUpdatedRangerPolicyJson "$json_payload" "$id"
