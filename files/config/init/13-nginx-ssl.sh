#!/bin/sh

#
# This script will be placed in /config/init/ and run when container starts.
# It creates (if they're not exist yet) necessary directories
# from where custom Nginx configs can be loaded (from mounted /data volumes).
#

set -e

mkdir -p /etc/nginx/ssl

openssl genrsa -out /etc/nginx/ssl/dummy.key 2048 2>/dev/null >/dev/null
openssl req -new -key /etc/nginx/ssl/dummy.key -out /etc/nginx/ssl/dummy.csr -subj "/C=US/L=Delaware/O=Company Inc/CN=docker" 2>/dev/null >/dev/null
openssl x509 -req -days 3650 -in /etc/nginx/ssl/dummy.csr -signkey /etc/nginx/ssl/dummy.key -out /etc/nginx/ssl/dummy.crt 2>/dev/null >/dev/null
