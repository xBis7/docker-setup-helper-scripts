#!/bin/bash

# Ranger API variables
HADOOP_RANGER_SERVICE="hadoopdev"
HIVE_RANGER_SERVICE="hivedev"


getRangerPolicyJsonRes() {
  service_name=$1
  policy_name=$2

  curl -s -u admin:rangerR0cks! -H "Content-Type: application/json" -X GET "http://localhost:6080/service/public/v2/api/service/$service_name/policy/$policy_name"
}

# Create a new Ranger policy.
createRangerPolicy() {
  json_payload=$1

  curl -iv -u admin:rangerR0cks! -H "Content-Type: application/json" -d "$json_payload" -X POST http://localhost:6080/service/public/v2/api/policy
}

# Update an existing Ranger policy.
putUpdatedRangerPolicyJson() {
  json_payload=$1
  id=$2

  curl -iv -u admin:rangerR0cks! -H "Content-Type: application/json" -d "$json_payload" -X PUT http://localhost:6080/service/public/v2/api/policy/$id
}

# Delete one of the existing Ranger policies.
deleteRangerPolicy() {
  id=$1

  curl -iv -u admin:rangerR0cks! -X DELETE http://localhost:6080/service/public/v2/api/policy/$id
}

getIdFromRangerPolicyJsonRes() {
  res=$1

  # Example: "id":22,
  # and we need to get just the number.
  id=$(echo "$res" | grep -o '"id":[0-9]*' | awk -F: '{print $2}')

  echo "$id"
}

getGuidFromRangerPolicyJsonRes() {
  res=$1
  
  # Example: "guid":"d0be1b59-31be-4d0f-94e9-e936f25d0794"
  # We need to get everything between the double quotes.
  # (tr -d '"') trims it and removes the quotes.
  guid=$(echo "$res" | grep -o '"guid":"[^"]*"' | awk -F':' '{print $2}' | tr -d '"')

  echo "$guid"
}

getResourceSignature() {
  res=$1
  
  # Example: "resourceSignature":"a6a328c623a4eb15d84ccf34df65c83acba3c59c7df4a601780b1caa153aa870"
  resource_sig=$(echo "$res" | grep -o '"resourceSignature":"[^"]*"' | awk -F':' '{print $2}' | tr -d '"')

  echo "$resource_sig"
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
  # Identation for 'values' is 6 spaces. We need to start from that.

  # Set IFS to a comma.
  IFS=','

  # The input will be split based on the IFS. Store each value in a tmp array.
  read -ra values_tmp <<< "$resource_values"

  array="[\n"

  values_tmp_size=${#values_tmp[@]}

  # Iterate over the tmp array to get each value and create the json array string.
  for (( i=0; i<$values_tmp_size; i++ )); do
    # 6 spaces for 'values' + 2.
    array+="        "
    array+="\"${values_tmp[$i]}\""

    # If this isn't the last element, then add a comma.
    if [ $i -lt $((values_tmp_size - 1)) ]; then
      array+=",\n"
    fi
  done
  # 6 spaces like 'values'.
  array+="\n      ]"

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
  # Identation for 'accesses' is 6 spaces. We need to start identation from that.
  accesses_array="["

  accesses_tmp_size=${#accesses_tmp[@]}

  # Iterate over the tmp array to get each value and create the json array string.
  for (( i=0; i<$accesses_tmp_size; i++ )); do
    accesses_array+="\n"
    # 6 spaces for 'acceeses' + 2.
    accesses_array+="        "
    accesses_array+="{\n"

    # 8 spaces for parent + 2.
    accesses_array+="          "
    accesses_array+="\"type\":\"${accesses_tmp[$i]}\","
    accesses_array+="\n"
    accesses_array+="          "
    accesses_array+="\"isAllowed\":true"

    accesses_array+="\n"
    # 6 spaces for 'acceeses' + 2.
    accesses_array+="        "
    accesses_array+="}"

    # If this isn't the last element, then add a comma.
    if [ $i -lt $((accesses_tmp_size - 1)) ]; then
      accesses_array+=","
    fi
  done
  # 6 spaces like 'accesses'.
  accesses_array+="\n      ]"

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
  # Identation for 'users' is 6 spaces. We need to start identation from that.
  users_array="[\n"

  users_tmp_size=${#users_tmp[@]}

  for (( i=0; i<$users_tmp_size; i++ )); do
    # 6 spaces for 'users' + 2.
    users_array+="        "
    users_array+="\"${users_tmp[$i]}\""

    # If this isn't the last element, then add a comma.
    if [ $i -lt $((users_tmp_size - 1)) ]; then
      users_array+=",\n"
    fi
  done
  # 6 spaces like 'users'.
  users_array+="\n      ]"

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

  IFS='/'

  read -ra conditions <<< "$policy_items"
  conditions_size=${#conditions[@]}

  policy_items_array="[\n"

  for (( i=0; i<$conditions_size; i++ )); do



  done

  IFS=' '

  echo -e "$policy_items_array"
}
