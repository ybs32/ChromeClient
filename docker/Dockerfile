# Build stage
FROM ubuntu:18.04 as build

# TODO: Multi stage build
ENV DISPLAY=:0

RUN set -x \
    && apt update \
    && apt install -y nodejs npm \
    && npm cache clean \
    && npm install -g n \
    && n 11.13.0 \
    && hash -r \
    && apt purge -y nodejs npm

WORKDIR /tmp
ARG CHROME_VERSION=google-chrome-stable_77.0.3865.90-1_amd64.deb
RUN set -x \
    && apt install -y wget \
    && wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/${CHROME_VERSION} \
    && apt install -y ./${CHROME_VERSION} \
    && rm ./${CHROME_VERSION}

RUN set -x \
    && apt autoremove -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

##############################

COPY ./script /var/www/script
COPY ./service /var/www/service
COPY ./extension /var/www/exntension

WORKDIR /var/www/service
RUN set -x \
    && npm install

WORKDIR /var/www/exntension
RUN set -x \
    && npm install \
    && npm run build \
    && cp ./app/scripts/env.js ./dist/chrome/scripts

WORKDIR /var/www/script
ENV USER=chrome
RUN set -x \
    && useradd -m -s /bin/bash ${USER} \
    && usermod -aG audio ${USER} \
    && chown -R $USER:$USER ./boot.sh \
    && chmod 755 ./boot.sh
USER ${USER}

# ENTRYPOINT ["/var/www/script/boot.sh"]