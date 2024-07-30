#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path"
fi

copyKeytabsUnderContainer() {
  abs_path=$1
  container_hostname=$2

  # Initialize an empty array.
  keytabs_array=()

  # Populate the array.
  keytabs_array+=("hadoop.dn1.keytab")
  keytabs_array+=("hadoop.nn.keytab")
  keytabs_array+=("HTTP.local.keytab")
  keytabs_array+=("rangeradmin.local.keytab")
  keytabs_array+=("rangerlookup.local.keytab")

  project_path="docker-setup-helper-scripts/compose"

  docker exec -u root -it ranger mkdir -p /etc/security/keytabs

  docker cp "$abs_path/$project_path/kerberos/conf/krb5.conf" "$container_hostname:/etc/krb5.conf"
  docker exec -u root -it ranger chown root:root /etc/krb5.conf
  docker exec -u root -it ranger chmod 655 /etc/krb5.conf

  for file in "${keytabs_array[@]}"
  do
    docker cp "$abs_path/$project_path/common/keytabs/$file" "$container_hostname:/etc/security/keytabs/$file"
    docker exec -u root -it ranger chown root:root /etc/security/keytabs/$file
    docker exec -u root -it ranger chmod 655 /etc/security/keytabs/$file
  done
}

copyKeytabsUnderContainer "$abs_path" "ranger"

# Kerberos base policies.
# ./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"

# waitForPoliciesUpdate

