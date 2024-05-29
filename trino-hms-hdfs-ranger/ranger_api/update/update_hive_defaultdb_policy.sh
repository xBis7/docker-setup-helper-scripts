#!/bin/bash

source "./ranger_api/lib.sh"

set -e

accesses=$1
users=$2
resources_column=${3:-"*"}
resources_table=${4:-"*"}

policy_name="default%20database%20tables%20columns"

# Get the JSON response from the Ranger API.
hivedev_res=$(getRangerPolicyJsonRes "$HIVE_RANGER_SERVICE" "$policy_name")

echo ""
echo "$hivedev_res"
echo ""

# Get the ID from the JSON response.
id=$(getIdFromRangerPolicyJsonRes "$hivedev_res")

# Get the GUID from the JSON response.
guid=$(getGuidFromRangerPolicyJsonRes "$hivedev_res")

resource_sig=$(getResourceSignature "$hivedev_res")

column_values_array=$(getResourcesJsonArray "$resources_column")
table_values_array=$(getResourcesJsonArray "$resources_table")

echo ""
echo "Splitting accesses and creating the json array."

accesses_array=$(getAccessesJsonArray "$accesses")

echo ""
echo "accesses_array:"
echo "$accesses_array"

echo ""
echo "Splitting users and creating the json array."

users_array=$(getUsersJsonArray "$users")

echo ""
echo "users array:"
echo "$users_array"

json_payload=$(cat <<EOF
{
  "id": $id,
  "guid": "$guid",
  "isEnabled":true,
  "service":"$HIVE_RANGER_SERVICE",
  "name":"default database tables columns",
  "resourceSignature":"$resource_sig",
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
  "policyItems":[
    {
      "accesses":$accesses_array,
      "users":$users_array,
      "delegateAdmin":false
    }
  ],
  "serviceType":"hive",
  "isDenyAllElse":false
}
EOF
)

putUpdatedRangerPolicyJson "$json_payload" "$id"
