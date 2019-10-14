FROM ubuntu:18.04

RUN set -x \
    && apt update \
    && apt install -y wget \
    && apt install -y nodejs npm --fix-missing

RUN set -x \
    && npm cache clean \
    && npm install -g n \
    && n stable \
    && hash -r

RUN set -x \
    && apt purge -y nodejs npm \
    && apt autoremove -y \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

### Install chrome
WORKDIR /tmp/chrome
ARG CHROME_VERSION=google-chrome-stable_77.0.3865.90-1_amd64.deb
RUN set -x \
    && wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/${CHROME_VERSION} \
    && apt install -y ./${CHROME_VERSION}

###
COPY ./docker/boot.sh /var/www/
COPY ./service /var/www/service/
COPY ./extension /var/www/exntension/

WORKDIR /var/www/service
RUN set -x \
    && npm install

###
WORKDIR /var/www/exntension
RUN set -x \
    && npm install \
    && npm run build \
    && cp ./app/scripts/env.js ./dist/chrome/scripts/

### Chrome User
WORKDIR /var/www/
ENV USER=chrome
RUN set -x \
    && useradd -m ${USER} \
    && chown -R $USER:$USER ./boot.sh \
    && chmod 755 ./boot.sh
USER ${USER}

# ENTRYPOINT ["/var/www/boot.sh"]