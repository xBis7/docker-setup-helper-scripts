#!/bin/bash

# Service names.
HADOOP_RANGER_SERVICE="hadoopdev"
HIVE_RANGER_SERVICE="hivedev"

# Policy names and URIs.
HDFS_ALL_POLICY_NAME="all - path"
HDFS_ALL_POLICY_URI_NAME="all%20-%20path"
HIVE_ALL_DB_POLICY_NAME="all - database, table, column"
HIVE_ALL_DB_POLICY_URI_NAME="all%20-%20database,%20table,%20column"
HIVE_DEFAULTDB_POLICY_NAME="default database tables columns"
HIVE_DEFAULTDB_POLICY_URI_NAME="default%20database%20tables%20columns"
HIVE_URL_POLICY_NAME="all - url"
HIVE_URL_POLICY_URI_NAME="all%20-%20url"

# Ranger ui variables.
RANGER_UI_USERNAME=
RANGER_UI_PASSWORD=
RANGER_UI_HOSTNAME=
RANGER_UI_PORT=

if [[ "${USE_RANGER_UI_CUSTOM_VALUES}" != "true" ]]; then
  RANGER_UI_USERNAME="admin"
  RANGER_UI_PASSWORD="rangerR0cks!"
  RANGER_UI_HOSTNAME="localhost"
  RANGER_UI_PORT="6080"
fi

getRangerPolicyJsonResponse() {
  service_name=$1
  policy_name=$2

  curl -s -u "$RANGER_UI_USERNAME":"$RANGER_UI_PASSWORD" -H "Content-Type: application/json" -X GET "http://$RANGER_UI_HOSTNAME:$RANGER_UI_PORT/service/public/v2/api/service/$service_name/policy/$policy_name"
}

getRangerPolicyJsonResponseUsingShortNames() {
  service=$1
  policy=$2

  service_name=
  policy_uri_name=

  if [ "$service" == "hdfs" ]; then
    service_name=$HADOOP_RANGER_SERVICE

    if [ "$policy" == "all" ]; then
      policy_uri_name="$HDFS_ALL_POLICY_URI_NAME"
    else
      # It's a custom name, set 'policy_name' to that.
      policy_uri_name="$policy"
    fi
  else
    service_name=$HIVE_RANGER_SERVICE

    if [ "$policy" == "all_db" ]; then
      policy_uri_name="$HIVE_ALL_DB_POLICY_URI_NAME"

    elif [ "$policy" == "defaultdb" ]; then
      policy_uri_name="$HIVE_DEFAULTDB_POLICY_URI_NAME"

    elif [ "$policy" == "url" ]; then
      policy_uri_name="$HIVE_URL_POLICY_URI_NAME"

    else
      # It's a custom name, set 'policy_name' to that.
      policy_uri_name="$policy"
    fi
  fi

  policy_res=$(getRangerPolicyJsonResponse "$service_name" "$policy_uri_name")

  echo "$policy_res"
}

# Create a new Ranger policy.
createRangerPolicy() {
  json_payload=$1

  # If we use 'jq' when creating each json string, then identation for each variable will be off.
  # Prettify the json.
  json_payload=$(echo "$json_payload" | jq '.')

  output=$(curl -s -o /dev/null -w "%{http_code}" -u "$RANGER_UI_USERNAME":"$RANGER_UI_PASSWORD" -H "Content-Type: application/json" -d "$json_payload" -X POST http://$RANGER_UI_HOSTNAME:$RANGER_UI_PORT/service/public/v2/api/policy)

  checkApiCallStatusCode "$output"
}

# Update an existing Ranger policy.
putUpdatedRangerPolicyJson() {
  json_payload=$1
  id=$2

  # Prettify the json.
  json_payload=$(echo "$json_payload" | jq '.')

  output=$(curl -s -o /dev/null -w "%{http_code}" -u "$RANGER_UI_USERNAME":"$RANGER_UI_PASSWORD" -H "Content-Type: application/json" -d "$json_payload" -X PUT http://$RANGER_UI_HOSTNAME:$RANGER_UI_PORT/service/public/v2/api/policy/$id)

  checkApiCallStatusCode "$output"
}

# Delete one of the existing Ranger policies.
deleteRangerPolicy() {
  id=$1

  output=$(curl -s -o /dev/null -w "%{http_code}" -u "$RANGER_UI_USERNAME":"$RANGER_UI_PASSWORD" -X DELETE http://$RANGER_UI_HOSTNAME:$RANGER_UI_PORT/service/public/v2/api/policy/$id)

  checkApiCallStatusCode "$output"
}

getIdFromRangerPolicyJsonResponse() {
  res=$1

  echo "$res" | jq '."id"'
}

getGuidFromRangerPolicyJsonResponse() {
  res=$1
  
  echo "$res" | jq '."guid"'
}

# If the policy has custom resources, then there is a resource signature.
# We can perform api calls without specifying this.
# This method is currently not used. I'm leaving it here in case it's needed.
getResourceSignature() {
  res=$1

  echo "$res" | jq '."resourceSignature"'
}

getAccessesJsonArray() {
  # This parameter will be a comma separated list of accesses.
  # e.g. 'select,update,lock,index'
  accesses=$1

  # Accesses example:
  #
  # "accesses":[
  #   {
  #     "type":"select",
  #     "isAllowed":true
  #   },
  #   {
  #     "type":"update",
  #     "isAllowed":true
  #   }
  # ],

  # Store to a tmp array.
  accesses_tmp=$(echo "$accesses" | jq -R 'split(",")')
  # Get the size of the tmp array.
  accesses_tmp_size=$(echo "$accesses_tmp" | jq '. | length')

  accesses_array="["

  # Iterate over the tmp array to get each value and create the json array string.
  for (( i=0; i<$accesses_tmp_size; i++ )); do
    access=$(echo "$accesses_tmp" | jq ".[$i]" | tr -d '"')

    accesses_array+="{"
    accesses_array+="\"type\":\"$access\","
    accesses_array+="\"isAllowed\":true"
    accesses_array+="}"

    # If this isn't the last element, then add a comma.
    if [ $i -lt $((accesses_tmp_size - 1)) ]; then
      accesses_array+=","
    fi
  done
  accesses_array+="]"

  echo -e "$accesses_array"
}

getJsonArrayFromCommaSeparatedList() {
  # This parameter will be a comma separated list of users or resources.
  # e.g. 'hadoop,spark,trino' or '/*,/test/*,/dir1/dir2/*'
  list=$1

  # Example method output:
  # [
  #   "/*",
  #   "/test/*",
  #   "/dir1/dir2/*"
  # ]

  json_array=$(echo "$list" | jq -R 'split(",")')

  echo -e "$json_array"
}

getPolicyItemsJsonArray() {
  # The policy_items parameter will have this format:
  # -select,drop,create:spark,hadoop/select:games,root
  #
  # We need to split it by '/'. That will give us each separate
  # allow condition as well as the number of them.
  # -select,drop,create:spark,hadoop
  # -select:games,root
  #
  # Next, we will split them by ':'. The first part will be the accesses and
  # the second part will be the users.
  # -select,drop,create
  # -spark,hadoop
  #
  # -select
  # -games,root
  #
  # Finally, we will split each by ','. That will give us each value.
  policy_items=$1

  # 'policyItems' example:
  #
  # "policyItems":[
  #   {
  #     "accesses":[
  #       {
  #           "type":"read",
  #           "isAllowed":true
  #       }
  #     ],
  #     "users":[
  #       "spark"
  #     ],
  #     "delegateAdmin":false
  #   },
  #   {
  #     "accesses":[
  #       {
  #           "type":"read",
  #           "isAllowed":true
  #       },
  #       {
  #           "type":"write",
  #           "isAllowed":true
  #       },
  #       {
  #           "type":"execute",
  #           "isAllowed":true
  #       }
  #     ],
  #     "users":[
  #       "hadoop"
  #     ],
  #     "delegateAdmin":false
  #   }
  # ],
  #
  # 'jq' will be used by the caller to prettify the result.

  conditions=$(echo "$policy_items" | jq -R 'split("/")')
  conditions_size=$(echo "$conditions" | jq '. | length')

  policy_items_array="["

  for (( i=0; i<$conditions_size; i++ )); do
    condition=$(echo "$conditions" | jq ".[$i]" | tr -d '"')

    items=$(echo "$condition" | jq -R 'split(":")')

    # items should have only two elements. 1. accesses, 2. users
    items_accesses=$(echo "$items" | jq ".[0]" | tr -d '"')
    items_users=$(echo "$items" | jq ".[1]" | tr -d '"')

    policy_items_array+="{"
    policy_items_array+="\"accesses\":"

    policy_items_array+=$(getAccessesJsonArray "$items_accesses")
    policy_items_array+=","

    policy_items_array+="\"users\":"
    policy_items_array+=$(getJsonArrayFromCommaSeparatedList "$items_users")
    policy_items_array+=","
    policy_items_array+="\"groups\":[],\"conditions\":[],"
    policy_items_array+="\"delegateAdmin\":true"
    policy_items_array+="}"

    # If this isn't the last element, then add a comma.
    if [ $i -lt $((conditions_size - 1)) ]; then
      policy_items_array+=","
    fi
  done
  policy_items_array+="]"

  echo -e "$policy_items_array"
}

checkApiCallStatusCode() {
  code=$1

  if [[ "$code" =~ 2[0-9][0-9] ]]; then
    echo ""
    echo -e "Status code: OK"
    echo ""
  else
    echo ""
    echo -e "Status code: $code"
    echo ""
  fi
}

checkIfPolicyExists() {
  service=$1
  policy=$2

  response=$(getRangerPolicyJsonResponseUsingShortNames "$service" "$policy")

  if $(echo "$response" | grep "Not found" > /dev/null); then
    echo "$service / $policy - Deleted successfully."
  else
    echo "$service / $policy - Delete failed."
    exit 1
  fi
}
