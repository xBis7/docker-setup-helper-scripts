For these tests to work, Hive needs to be setup to enable Hive URL policies.

To do so add next property
```
<property>
    <name>ranger.plugin.hive.urlauth.filesystem.schemes</name>
    <value>file:</value>
</property>
```
to Hive (path from repo root: `packaging/src/standalone-metastore/compose/hive-metastore-ranger/conf/ranger-hive-security.xml`).

After adding above property, restart Hive service for change to be picked up. The best way to set environment and run tests is to run `test_hive_url_policies.sh` script.

Reference: https://docs.cloudera.com/runtime/7.2.17/security-ranger-authorization/topics/security-ranger-hive-auth-url-policy.html