For these tests to work, Hive needs to be setup to enable Hive URL policies.

To do so add next property
```
<property>
    <name>ranger.plugin.hive.urlauth.filesystem.schemes</name>
    <value>file:,wasb:,adl:</value>
</property>
```
to Hive (path from repo root: `packaging/src/standalone-metastore/compose/hive-metastore-ranger/conf/ranger-hive-security.xml`).

Reference: https://docs.cloudera.com/runtime/7.2.17/security-ranger-authorization/topics/security-ranger-hive-auth-url-policy.html