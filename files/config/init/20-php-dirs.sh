#!/bin/sh

#
# This script will be placed in /config/init/ and run when container starts.
# It creates (if they're not exist yet) necessary Nginx directories
# @see /etc/nginx/addon.d/fastcgi-cache.example
#

set -e

mkdir -p /data/conf/php-fpm
mkdir -p /data/tmp/php/{uploads,sessions}
mkdir -p /data/tmp/nginx/{fastcgi_cache,fastcgi_cache_tmp}

set +e

chown -R nobody:nobody /data/tmp/php /data/tmp/nginx/fastcgi_cache* & 2>&1
