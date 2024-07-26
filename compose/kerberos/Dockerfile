FROM alpine:3.13.2
# hadolint ignore=DL3018
RUN apk add --no-cache bash ca-certificates openssl krb5-server krb5 wget && update-ca-certificates && \
   wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
   chmod +x /usr/local/bin/dumb-init
WORKDIR /opt
COPY conf/krb5.conf /etc/
COPY kadm5.acl /var/lib/krb5kdc/kadm5.acl
COPY init.sh .
RUN chmod +x ./init.sh && ./init.sh
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
