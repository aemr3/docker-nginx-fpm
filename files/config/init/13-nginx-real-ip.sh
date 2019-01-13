#!/bin/sh

REAL_IP_SOURCE_CONF="/config/init/http-real-ip.conf"
REAL_IP_TARGET_CONF="/etc/nginx/addon.d/http-real-ip.conf"

if [ "${NGINX_ENABLE_REAL_IP^^}" = TRUE ]; then
  cat $REAL_IP_SOURCE_CONF > $REAL_IP_TARGET_CONF
  sed -i "s#0.0.0.0/0#${NGINX_REAL_IP_FROM}#" $REAL_IP_TARGET_CONF
  sed -i "s#X-Forwarded-For#${NGINX_REAL_IP_HEADER}#" $REAL_IP_TARGET_CONF
fi
