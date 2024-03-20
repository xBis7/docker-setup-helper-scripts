There is an issue with starting Spark worker with official Docker image apache/spark:v3.3.2 https://hub.docker.com/layers/apache/spark/v3.3.2/images/sha256-30ae5023fc384ae3b68d2fb83adde44b1ece05f926cfceecac44204cdc9e79cb?context=explore.

More info can be found here: https://github.com/G-Research/gr-oss/issues/614

Because of the above-mentioned issue, Dockerfile and entrypoint.sh are copied from official https://github.com/apache/spark-docker repo (SHA 4f2d96a415c89cfe0fde89a55e9034d095224c94). Dockerfile is further modified for our needs.