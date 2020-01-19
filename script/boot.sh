#!/bin/bash
node /var/www/service/bin/www &

# Make chrome user-data directory
mkdir -p /home/chrome/.config/google-chrome

# Start google chrome
GENERAL_OPTIONS="--incognito --no-default-browser-check"
SECURITY_OPTIONS="--no-sandbox --ignore-certificate-errors --allow-running-insecure-content"
STORAGE_OPTIONS="--disable-dev-shm-usage --user-data-dir=/home/chrome/.config/google-chrome"
google-chrome-stable $GENERAL_OPTIONS $SECURITY_OPTIONS $STORAGE_OPTIONS &

# Keep container running
tail -f /dev/null