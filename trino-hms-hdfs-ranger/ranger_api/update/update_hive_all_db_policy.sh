#!/bin/bash

source "./ranger_api/lib.sh"

set -e

accesses=$1
users=$2

policy_name="all%20-%20database,%20table,%20column"

# Get the JSON response from the Ranger API.
hivedev_res=$(getRangerPolicyJsonRes "$HIVE_RANGER_SERVICE" "$policy_name")

echo ""
echo "$hivedev_res"
echo ""

# Get the ID from the JSON response.
id=$(getIdFromRangerPolicyJsonRes "$hivedev_res")

# Get the GUID from the JSON response.
guid=$(getGuidFromRangerPolicyJsonRes "$hivedev_res")

resource_sig=$(getHiveUrlResourceSignature "$hivedev_res")

echo ""
echo "id: $id"
echo "guid: $guid"
echo "resourceSignature: $resource_sig"
echo ""

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
  "name":"all - database, table, column",
  "resourceSignature":"$resource_sig",
  "resources":{
    "database":{
      "values":[
        "*"
      ],
      "isExcludes":false,
      "isRecursive":false
    },
    "column":{
      "values":[
        "*"
      ],
      "isExcludes":false,
      "isRecursive":false
    },
    "table":{
      "values":[
        "*"
      ],
      "isExcludes":false,
      "isRecursive":false
    }
  },
  "policyItems":[
    {
      "accesses":$accesses_array,
      "users":$users_array,
      "delegateAdmin":true
    }
  ],
  "serviceType":"hive",
  "isDenyAllElse":false
}
EOF
)

putUpdatedRangerPolicyJson "$json_payload" "$id"
