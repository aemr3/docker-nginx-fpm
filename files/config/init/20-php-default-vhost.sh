#!/bin/sh

#
# Configure default vhost, if NGINX_GENERATE_DEFAULT_VHOST is set to TRUE
# See README for more info.
#

if [ "${NGINX_GENERATE_DEFAULT_VHOST^^}" = TRUE ]; then
  if [ "${NGINX_INSTALL_DEFAULT_VHOST_FILES^^}" = TRUE ]; then
    echo "default vhost # created on $(date)" > /data/www/default/index.php
    echo "<?php phpinfo();" >> /data/www/default/index.php
    echo "Nginx: default *catch-all* vhost with PHP support generated."; echo
  fi
fi
