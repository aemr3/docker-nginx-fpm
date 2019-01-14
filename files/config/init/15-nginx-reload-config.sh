#!/bin/sh

NGINX_RELOAD_CONFIG_FILE="/etc/supervisor/conf.d/nginx-reload.conf"

if [ "${NGINX_RELOAD_CONFIG^^}" = FALSE ]; then
  rm $NGINX_RELOAD_CONFIG_FILE
fi
