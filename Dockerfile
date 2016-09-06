FROM alpine:3.4

RUN set -x && \
    apk add --no-cache -t .deps ca-certificates curl && \
    # Install glibc on Alpine (required by docker-compose) from
    # https://github.com/sgerrand/alpine-pkg-glibc
    # See also https://github.com/gliderlabs/docker-alpine/issues/11
    GLIBC_VERSION='2.23-r3' && \
    curl -Lo /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    curl -Lo glibc.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-$GLIBC_VERSION.apk && \
    curl -Lo glibc-bin.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-bin-$GLIBC_VERSION.apk && \
    apk update && \
    apk add glibc.apk glibc-bin.apk && \
    rm -rf /var/cache/apk/* glibc.apk glibkc-bin.apk && \
    \
    # Install docker-compose
    # https://docs.docker.com/compose/install/
    curl -Lo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.8.0/docker-compose-Linux-x86_64 && \
    chmod a+rx /usr/local/bin/docker-compose && \
    docker-compose version && \
    \
    # Clean-up
    apk del .deps