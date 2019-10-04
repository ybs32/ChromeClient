FROM ubuntu:18.04

### Display commands to be executed
RUN set -x \
    && apt update \
    && apt upgrade \

### TODO: 書く
ENV USER=chrome