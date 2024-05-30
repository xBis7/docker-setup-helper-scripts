#!/bin/bash

# This script needs to be run with 'source'.

username=$1
password=$2
hostname=$3
port=$4

export USE_RANGER_UI_CUSTOM_VALUES="true"
export RANGER_UI_USERNAME="$username"
export RANGER_UI_PASSWORD="$password"
export RANGER_UI_HOSTNAME="$hostname"
export RANGER_UI_PORT="$port"
