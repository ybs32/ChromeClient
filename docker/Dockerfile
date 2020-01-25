##### Build Stage
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

##### Deploy Stage
FROM ybs32/google-chrome-stable:77.0.3865.90-1

RUN set -x \
    && apt update \
    && apt install -y \
       less \
       pulseaudio \
    && apt autoremove -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./ChromeClient/script /var/www/script
COPY --from=build /ChromeClient/service /var/www/service
COPY --from=build /ChromeClient/extension/dist/chrome /var/www/extension/chrome

ARG USER=chrome
ARG UID=1001
RUN set -x \
    && useradd -m -u ${UID} -s /bin/bash ${USER} \
    && usermod -aG audio ${USER} \
    && mkdir -p /run/user/${UID} \
    && mkdir -p /home/${USER}/.config \
    && chown -R $USER:$USER /run/user/${UID} \
    && chown -R $USER:$USER /home/${USER}/.config \
    && chown -R $USER:$USER /var/www/script/* \
    && chmod 755 /var/www/script/*

USER ${USER}
ENTRYPOINT ["/var/www/script/boot.sh"]