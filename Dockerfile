FROM alpine:3.18.3

# Build GOST-engine for OpenSSL
ARG GOST_ENGINE_VERSION=3.0.2
ARG GOST_ENGINE_SHA256="fec8bd02fd19d346d74d58c2f3e1d483e9d98802aed83cdaf288481b4a504846"

RUN apk add --no-cache --virtual .build-deps \
  build-base \
  coreutils \
  perl \
  autoconf \
  dpkg-dev dpkg \
  file \
  g++ \
  gcc \
  libc-dev \
  make \
  cmake \
  pkgconf \
  re2c \
  linux-headers \
  unzip \
  wget \
  openssl-dev \
  && apk add --no-cache openssl \
  && wget "https://github.com/gost-engine/engine/archive/refs/tags/v${GOST_ENGINE_VERSION}.zip" -O /gost-engine.zip \
  && wget "https://github.com/provider-corner/libprov/archive/refs/heads/main.zip" -O /libprov.zip \
  && echo "$GOST_ENGINE_SHA256" /gost-engine.zip | sha256sum -c - \
  && mkdir -p /tmp && cd /tmp  \
  && unzip  /gost-engine.zip -d ./ && unlink /gost-engine.zip \
  && unzip  /libprov.zip -d ./ && unlink /libprov.zip \
  && cd "engine-${GOST_ENGINE_VERSION}" \
  && cp -r /tmp/libprov-main/* libprov \
  && mkdir build && cd build \
  && cmake .. \
         -DCMAKE_BUILD_TYPE=Release \
         -DCMAKE_INSTALL_PREFIX=/usr \
  && cmake --build . --config Release \
  && cmake --build . --target install --config Release \
  && cd "/tmp/engine-${GOST_ENGINE_VERSION}/build" \
  && ls -la \
  && cmake --build . --target install --config Release \
  && ls -la && ls -la /usr/lib/engines-3/gost.so \
  && echo "openssl engine gost -c" \
  && openssl engine gost -c \
  && cd / \
  && rm -rf "/tmp/*" \
  && apk del .build-deps

# Enable engine
ADD gost.cnf /gost.cnf

RUN sed -i 's/openssl_conf = openssl_init/openssl_conf = openssl_gost/g' /etc/ssl/openssl.cnf \
    && cat /gost.cnf >> /etc/ssl/openssl.cnf \
    && cat /etc/ssl/openssl.cnf \
    && sed -i "s#\[default_sect\]#\[default_sect\]\nMinProtocol\=TLSv1.2\nCipherString = DEFAULT:@SECLEVEL=1#g" /etc/ssl/openssl.cnf \
    && cat /etc/ssl/openssl.cnf  \
    && openssl engine gost -c \
    && openssl ciphers | tr ':' '\n' | grep GOST