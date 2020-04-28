FROM docker.io/alpine

RUN \
  apk add --no-cache \
    bash \
    curl \
    git \
  ;
