#!/bin/sh

#
# This script will be placed in /config/init/ and run when container starts.
# It creates (if they're not exist yet) necessary directories
# from where custom Nginx configs can be loaded (from mounted /data volumes).
#

set -e

mkdir -p /data/conf/nginx/{addon.d,conf.d,hosts.d,nginx.d}
chmod 711 /data/conf/nginx

mkdir -p /data/tmp/nginx/{client_temp,proxy_temp}
chmod 711 /data/tmp/nginx

mkdir -p /data/www
chown -R www-data:www-data /data/www
