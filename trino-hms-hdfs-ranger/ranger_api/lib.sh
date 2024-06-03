#!/bin/bash

# Service names.
HADOOP_RANGER_SERVICE="hadoopdev"
HIVE_RANGER_SERVICE="hivedev"

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

# Create a new Ranger policy.
createRangerPolicy() {
  json_payload=$1

  # If we use 'jq' when creating each json string, then identation for each variable will be off.
  # Prettify the json.
  json_payload=$(echo "$json_payload" | jq '.')

  curl -iv -u "$RANGER_UI_USERNAME":"$RANGER_UI_PASSWORD" -H "Content-Type: application/json" -d "$json_payload" -X POST http://$RANGER_UI_HOSTNAME:$RANGER_UI_PORT/service/public/v2/api/policy
}

# Update an existing Ranger policy.
putUpdatedRangerPolicyJson() {
  json_payload=$1
  id=$2

  # Prettify the json.
  json_payload=$(echo "$json_payload" | jq '.')

  curl -iv -u "$RANGER_UI_USERNAME":"$RANGER_UI_PASSWORD" -H "Content-Type: application/json" -d "$json_payload" -X PUT http://$RANGER_UI_HOSTNAME:$RANGER_UI_PORT/service/public/v2/api/policy/$id
}

# Delete one of the existing Ranger policies.
deleteRangerPolicy() {
  id=$1

  curl -iv -u "$RANGER_UI_USERNAME":"$RANGER_UI_PASSWORD" -X DELETE http://$RANGER_UI_HOSTNAME:$RANGER_UI_PORT/service/public/v2/api/policy/$id
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

getResourcesJsonArray() {
  resource_values=$1

  # Resources example:
  #
  # "resources":{
  #   "database":{
  #     "values":[
  #       "default"
  #     ],
  #     "isExcludes":false,
  #     "isRecursive":false
  #   },
  #   "column":{
  #     "values":[
  #       "*"
  #     ],
  #     "isExcludes":false,
  #     "isRecursive":false
  #   }
  # },
  #
  # 'jq' will be used by the caller to prettify the result.

  # Set IFS to a comma.
  IFS=','

  # The input will be split based on the IFS. Store each value in a tmp array.
  read -ra values_tmp <<< "$resource_values"

  array="["

  values_tmp_size=${#values_tmp[@]}

  # Iterate over the tmp array to get each value and create the json array string.
  for (( i=0; i<$values_tmp_size; i++ )); do
    array+="\"${values_tmp[$i]}\""

    # If this isn't the last element, then add a comma.
    if [ $i -lt $((values_tmp_size - 1)) ]; then
      array+=","
    fi
  done
  array+="]"

  # Reset IFS to its default value.
  IFS=' '

  echo -e "$array"
}

getAccessesJsonArray() {
  accesses=$1

  # Set IFS to a comma.
  IFS=','

  # The input will be split based on the IFS. Store each value in a tmp array.
  read -ra accesses_tmp <<< "$accesses"

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
  #
  # 'jq' will be used by the caller to prettify the result.
  accesses_array="["

  accesses_tmp_size=${#accesses_tmp[@]}

  # Iterate over the tmp array to get each value and create the json array string.
  for (( i=0; i<$accesses_tmp_size; i++ )); do
    accesses_array+="{"
    accesses_array+="\"type\":\"${accesses_tmp[$i]}\","
    accesses_array+="\"isAllowed\":true"
    accesses_array+="}"

    # If this isn't the last element, then add a comma.
    if [ $i -lt $((accesses_tmp_size - 1)) ]; then
      accesses_array+=","
    fi
  done
  accesses_array+="]"

  # Reset IFS to its default value.
  IFS=' '

  echo -e "$accesses_array"
}

getUsersJsonArray() {
  users=$1

  # Set IFS to a comma.
  IFS=','

  read -ra users_tmp <<< "$users"

  # Users example:
  #
  # "users":[
  #   "root"
  # ],
  #
  # 'jq' will be used by the caller to prettify the result.
  users_array="["
  users_tmp_size=${#users_tmp[@]}

  for (( i=0; i<$users_tmp_size; i++ )); do
    users_array+="\"${users_tmp[$i]}\""

    # If this isn't the last element, then add a comma.
    if [ $i -lt $((users_tmp_size - 1)) ]; then
      users_array+=","
    fi
  done
  users_array+="]"

  # Reset IFS to its default value.
  IFS=' '

  echo -e "$users_array"
}

getPolicyItemsJsonArray() {
  policy_items=$1

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

  IFS='/'

  read -ra conditions <<< "$policy_items"

  # We got the conditions. Reset IFS so that we can use it to split each condition.
  IFS=' '

  conditions_size=${#conditions[@]}

  policy_items_array="["

  for (( i=0; i<$conditions_size; i++ )); do
    condition="${conditions[$i]}"

    IFS=':'
    read -ra items <<< "$condition"
    IFS=' '

    policy_items_array+="{"
    policy_items_array+="\"accesses\":"

    # items should have only two elements. 1. accesses, 2. users
    policy_items_array+=$(getAccessesJsonArray "${items[0]}")
    policy_items_array+=","

    policy_items_array+="\"users\":"
    policy_items_array+=$(getUsersJsonArray "${items[1]}")
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
  cmd=$1
  msg=$2

  tmp_file="ranger_api/tmp.txt"

  $cmd 2>&1 | tee $tmp_file > /dev/null

  if (grep -q "HTTP/1.1 2[0-9][0-9]" "$tmp_file" > /dev/null); then
    echo -e "$msg, status code: OK"
  else
    code=$(grep -o "HTTP/1.1 [2-5][0-9][0-9]" "$tmp_file" | awk '{print $2}')
    echo -e "$msg, status code: $code"
  fi
}
