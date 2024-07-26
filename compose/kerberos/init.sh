#!/bin/bash

set -e

# This is creating a new Kerberos database.
# -s: creates a stash file that contains the master key and password encrypted.
#     kerberos server will use the stash file to get the master key and start.
# -P password: 'password' is the password for the master key.
kdb5_util create -s -P password

# Generate principals.
kadmin.local -q "addprinc -randkey admin/admin@EXAMPLE.COM"
