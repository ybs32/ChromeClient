FROM ubuntu:18.04

RUN set -x \
    && apt update \
    && apt install -y nodejs npm wget

### Install chrome
WORKDIR /tmp/chrome
ARG CHROME_VERSION=google-chrome-stable_77.0.3865.90-1_amd64.deb
RUN set -x \
    && wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/${CHROME_VERSION} \
    && apt install -y ./${CHROME_VERSION}

###
COPY ./boot.sh /var/www/
COPY ./service /var/www/service

WORKDIR /var/www/service
RUN set -x \
    && npm install

### Chrome User
# ENV USER=chrome
# RUN useradd -m ${USER}
# USER ${USER}}

# ENTRYPOINT ["/var/www/boot.sh"]