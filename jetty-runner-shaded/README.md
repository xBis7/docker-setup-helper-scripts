## TLDR

This maven project has been created in order to generate a shaded version of the `org.eclipse.jetty:jetty-runner` jar and install it locally. The shaded jar will be used while building Hive.

You can generate the jar and install it by running the script under this project

```shell
./install_jetty_runner_jar.sh
```

## Issue

Hadoop 3.3.6 uses jetty version `9.4.51.v20230217` while Hive uses jetty version `9.4.40.v20210413`.

When upgrading Hive's Hadoop dependency, we also have to upgrade the jetty version that Hive is using, in order to match Hadoop's jetty version.

Hadoop uses classes from this dependency

```xml
<dependency>
  <groupId>org.apache.directory.api</groupId>
  <artifactId>api-ldap-model</artifactId>
</dependency>
```

Hive doesn't have the `org.apache.directory.api:api-ldap-model` dependency but it has the `org.eclipse.jetty:jetty-runner` dependency which contains its own version of the entire `org.apache.directory.api` package.

The issue is that
* Hive calls Hadoop code
* The Hadoop code calls some classes from the `org.apache.directory.api` package
* Hadoop expects that these classes will be implemented by `api-ldap-model` dependency
* Hive doesn't have the dependency but it can find the classes from the `org.apache.directory.api` package that exists under the `jetty-runner` dependency and can be found on the classpath 
* When Hive calls the Hadoop code, we get this exception `java.lang.IncompatibleClassChangeError: Implementing class`

## Solution

A possible solution would be to use the `maven-shade-plugin` in order to rename the package `org.apache.directory.api` package under the `jetty-runner` dependency so that when Hive tries to access the classes, it will not find them under the `jetty-runner` jar. The `jetty-runner org.apache.directory.api` classes will need to be imported with their new package name, in order to be used.

After creating the shaded jar with the renamed `org.apache.directory.api` package, we will need to set the classifier shaded in every `jetty-runner` dependency in Hive, to make sure that the new jar is used.

```xml
<dependency>
  <groupId>org.eclipse.jetty</groupId>
  <artifactId>jetty-runner</artifactId>
  <version>${jetty.version}</version>
  <classifier>shaded</classifier>
</dependency>
```

## Reason for this project

The jar shading occurs in the `package` phase of the maven life cycle. 

Maven reads the `classifier` shaded before the shaded jar has been generated and it tries to look for it in the maven central. But this is a custom jar and as a result, we end up with an error that it doesn't exist.

The solution would be to generate the jar locally before building Hive and installing it under the local maven repo.

This project doesn't have any source files. It only contains the `jetty-runner` dependency. When building the project, the generated jar contains only the files of the `jetty-runner` jar. 

It also performs the jar shading during the package phase.

After building the project and generating the jar, we install it locally.

This Hive dependency will now use to the local jar and the Hive build will succeed.

```xml
<dependency>
  <groupId>org.eclipse.jetty</groupId>
  <artifactId>jetty-runner</artifactId>
  <version>${jetty.version}</version>
  <classifier>shaded</classifier>
</dependency>
```

This project needs to be setup locally at least once before every Hive build.

