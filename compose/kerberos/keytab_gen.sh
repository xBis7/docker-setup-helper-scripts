#!/bin/bash

set -e

# HDFS principals.
kadmin.local -q "addprinc -randkey hadoop/nn@EXAMPLE.COM"
kadmin.local -q "addprinc -randkey hadoop/dn1@EXAMPLE.COM"

# Generate keytab files using the generated principals.
kadmin.local -q "ktadd -k /etc/security/keytabs/hadoop.nn.keytab hadoop/nn@EXAMPLE.COM"
kadmin.local -q "ktadd -k /etc/security/keytabs/hadoop.dn1.keytab hadoop/dn1@EXAMPLE.COM"
