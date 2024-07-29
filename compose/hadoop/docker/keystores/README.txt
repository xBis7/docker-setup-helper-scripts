I've used these commands to setup the files that can be found in this directory.

- Generate a self-signed certificate for the server
  > keytool -genkeypair -alias hadoop-server -keyalg RSA -keystore ssl-server-keystore.jks -storepass changeit -keypass changeit -dname "CN=server, OU=Hadoop, O=Hadoop, L=San Francisco, ST=CA, C=US"

- Export the server certificate
  > keytool -exportcert -alias hadoop-server -keystore ssl-server-keystore.jks -storepass changeit -file hadoop-server-cert.cer

- Generate a self-signed certificate for the client
  > keytool -genkeypair -alias hadoop-client -keyalg RSA -keystore ssl-client-keystore.jks -storepass changeit -keypass changeit -dname "CN=client, OU=Hadoop, O=Hadoop, L=San Francisco, ST=CA, C=US"

- Export the client certificate 
  > keytool -exportcert -alias hadoop-client -keystore ssl-client-keystore.jks -storepass changeit -file hadoop-client-cert.cer

- Import the server certificate into the client truststore
  > keytool -importcert -alias hadoop-server -file hadoop-server-cert.cer -keystore ssl-client-truststore.jks -storepass changeit -noprompt

- Import the client certificate into the server truststore
  > keytool -importcert -alias hadoop-client -file hadoop-client-cert.cer -keystore ssl-server-truststore.jks -storepass changeit -noprompt
