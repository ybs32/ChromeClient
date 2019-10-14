#!/bin/bash
/usr/bin/node /var/www/service/bin/www &

OPTIONS="--no-sandbox --incognito  --ignore-certificate-errors --allow-running-insecure-content"
/usr/bin/google-chrome-stable $OPTIONS &