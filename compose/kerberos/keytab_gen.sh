#!/bin/bash

set -e

# -- HDFS --

# Principals
kadmin.local -q "addprinc -randkey hadoop/nn@EXAMPLE.COM"
kadmin.local -q "addprinc -randkey hadoop/dn1@EXAMPLE.COM"

# Generate keytab files using the generated principals.
kadmin.local -q "ktadd -k /etc/security/keytabs/hadoop.nn.keytab hadoop/nn@EXAMPLE.COM"
kadmin.local -q "ktadd -k /etc/security/keytabs/hadoop.dn1.keytab hadoop/dn1@EXAMPLE.COM"


# -- Ranger --

# Principals
kadmin.local -q "addprinc -randkey HTTP/local@EXAMPLE.COM"
kadmin.local -q "addprinc -randkey rangeradmin/local@EXAMPLE.COM"
kadmin.local -q "addprinc -randkey rangerlookup/local@EXAMPLE.COM"

# Generate keytab files using the generated principals.
kadmin.local -q "ktadd -k /etc/security/keytabs/HTTP.local.keytab HTTP/local@EXAMPLE.COM"
kadmin.local -q "ktadd -k /etc/security/keytabs/rangeradmin.local.keytab rangeradmin/local@EXAMPLE.COM"
kadmin.local -q "ktadd -k /etc/security/keytabs/rangerlookup.local.keytab rangerlookup/local@EXAMPLE.COM"
