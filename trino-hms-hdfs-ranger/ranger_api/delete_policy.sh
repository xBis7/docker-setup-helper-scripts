#!/bin/bash

source "./ranger_api/lib.sh"

set -e

service=$1
policy=$2

service_name=
policy_uri_name=

if [ "$service" == "hdfs" ]; then
  service_name=$HADOOP_RANGER_SERVICE

  if [ "$policy" == "all" ]; then
    policy_uri_name="all%20-%20path"
  else
    # It's a custom name, set 'policy_name' to that.
    policy_uri_name="$policy"
  fi
else
  service_name=$HIVE_RANGER_SERVICE

  if [ "$policy" == "all_db" ]; then
    policy_uri_name="all%20-%20database,%20table,%20column"

  elif [ "$policy" == "defaultdb" ]; then
    policy_uri_name="default%20database%20tables%20columns"

  elif [ "$policy" == "url" ]; then
    policy_uri_name="all%20-%20url"

  else
    # It's a custom name, set 'policy_name' to that.
    policy_uri_name="$policy"
  fi
fi

# Get the JSON response from the Ranger API.
policy_res=$(getRangerPolicyJsonResponse "$service_name" "$policy_uri_name")

# Get the ID from the JSON response.
id=$(getIdFromRangerPolicyJsonResponse "$policy_res")

echo ""
echo "Deleting Ranger policy with id: $id"
echo ""

deleteRangerPolicy "$id"
