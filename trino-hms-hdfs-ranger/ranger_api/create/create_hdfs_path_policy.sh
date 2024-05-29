#!/bin/bash

source "./ranger_api/lib.sh"

set -e

resources_path=$1
accesses=$2
users=$3

policy_name="all - path" # This isn't part of a URI and shouldn't include ASCII chars.

resource_values_array=$(getResourcesJsonArray "$resources_path")
accesses_array=$(getAccessesJsonArray "$accesses")
users_array=$(getUsersJsonArray "$users")

json_payload=$(cat <<EOF
{
  "isEnabled": true,
  "service": "$HADOOP_RANGER_SERVICE",
  "name": "$policy_name",
  "isAuditEnabled":true,
  "resources":{
    "path": {
      "values":$resource_values_array,
      "isExcludes": false,
      "isRecursive": true
    }
  },
  "policyItems":[
    {
      "accesses":$accesses_array,
      "users":$users_array,
      "groups":[
        
      ],
      "conditions":[
        
      ],
      "delegateAdmin":false
    }
  ],
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

createRangerPolicy "$json_payload"
