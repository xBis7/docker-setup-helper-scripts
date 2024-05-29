#!/bin/bash

source "./ranger_api/lib.sh"

set -e

resources_path=$1
policy_items=$2

policy_name="all%20-%20path"

# We can't directly add or delete an allow condition to a Ranger policy
# but we can use PUT to update a policy with more than one allow confitions.
# We need to provide the appropriate json.

# Get the JSON response from the Ranger API.
hadoopdev_res=$(getRangerPolicyJsonRes "$HADOOP_RANGER_SERVICE" "$policy_name")

# Get the ID from the JSON response.
id=$(getIdFromRangerPolicyJsonRes "$hadoopdev_res")

# Get the GUID from the JSON response.
guid=$(getGuidFromRangerPolicyJsonRes "$hadoopdev_res")

resource_values_array=$(getResourcesJsonArray "$resources_path")

policy_items_array=$(getPolicyItemsJsonArray "$policy_items")

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
  "policyItems":$policy_items_array,
  "serviceType":"hdfs",
  "isDenyAllElse":false
}
EOF
)

echo ""
echo "$json_payload"

putUpdatedRangerPolicyJson "$json_payload" "$id"
