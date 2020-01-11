##### Build stage
FROM ybs32/node:11.13.0 as build

COPY ./ChromeClient /ChromeClient

WORKDIR /ChromeClient/service
RUN set -x \
    && npm install

WORKDIR /ChromeClient/extension
RUN set -x \
    && npm install \
    && npm run build \
    && cp ./app/scripts/env.js ./dist/chrome/scripts

##### Deploy stage
FROM ybs32/google-chrome-stable:77.0.3865.90-1

ENV DISPLAY=:0

COPY ./ChromeClient/script /var/www/script
COPY --from=build /ChromeClient/service /var/www/service
COPY --from=build /ChromeClient/extension/dist/chrome /var/www/extension/chrome

WORKDIR /var/www/script
ENV USER=chrome
RUN set -x \
    && useradd -m -s /bin/bash ${USER} \
    && usermod -aG audio ${USER} \
    && chown -R $USER:$USER ./boot.sh \
    && chmod 755 ./boot.sh
USER ${USER}

# ENTRYPOINT ["/var/www/script/boot.sh"]