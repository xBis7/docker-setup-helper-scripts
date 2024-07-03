#!/bin/bash

source "./ranger_api/lib.sh"

set -e

request_type=$1

# It can be like this for multiple conditions:
# accesses1:users1/accesses2:users2/accesses3:users3
# If there is only 1 allow condition, then it will be just: accesses1:users1
policy_items=$2
resources_column=${3:-"*"}
resources_table=${4:-"*"}

json_payload+="{"

# If it's not a create request, then we need to include the id and the guid in the json.
if [ "$request_type" != "create" ]; then
  # Get the JSON response from the Ranger API.
  hivedev_res=$(getRangerPolicyJsonResponse "$HIVE_RANGER_SERVICE" "$HIVE_DEFAULTDB_POLICY_URI_NAME")

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

column_values_array=$(getJsonArrayFromCommaSeparatedList "$resources_column")
table_values_array=$(getJsonArrayFromCommaSeparatedList "$resources_table")

policy_items_array=$(getPolicyItemsJsonArray "$policy_items")

json_payload+=$(cat <<EOF
  "isEnabled":true,
  "service":"$HIVE_RANGER_SERVICE",
  "name":"$HIVE_DEFAULTDB_POLICY_NAME",
  "isAuditEnabled":true,
  "resources":{
    "database":{
      "values":[
        "default"
      ],
      "isExcludes":false,
      "isRecursive":false
    },
    "column":{
      "values":$column_values_array,
      "isExcludes":false,
      "isRecursive":false
    },
    "table":{
      "values":$table_values_array,
      "isExcludes":false,
      "isRecursive":false
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
  echo ""
  echo "-- Creating Ranger policy: hive / $HIVE_DEFAULTDB_POLICY_NAME"

  createRangerPolicy "$json_payload"
else
  echo ""
  echo "-- Updating Ranger policy: hive / $HIVE_DEFAULTDB_POLICY_NAME"

  putUpdatedRangerPolicyJson "$json_payload" "$id"
fi

