#!/bin/bash
node /var/www/service/bin/www &

OPTIONS="--no-sandbox --incognito  --ignore-certificate-errors --allow-running-insecure-content"
google-chrome-stable $OPTIONS &

# Keep container running
tail -f /dev/null