FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8

ENV NGINX_GENERATE_DEFAULT_VHOST false
ENV NGINX_RELOAD_CONFIG true
ENV NGINX_INSTALL_DEFAULT_VHOST_FILES false
ENV NGINX_DEFAULT_VHOST_ROOT_PATH /data/www/default
ENV NGINX_ENABLE_REAL_IP false
ENV NGINX_REAL_IP_FROM 0.0.0.0/0
ENV NGINX_REAL_IP_HEADER X-Forwarded-For
ENV STATUS_PAGE_ALLOWED_IP 127.0.0.1

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    php7.1-cli php7.1-fpm php7.1-curl php7.1-bcmath php7.1-gd php7.1-geoip php7.1-gmp php7.1-imagick php7.1-intl \
    php7.1-json php7.1-mbstring php7.1-memcached php7.1-mcrypt php7.1-mysql php7.1-redis php7.1-opcache \
    php-pear php7.1-pspell php7.1-soap php7.1-xml php7.1-zip \
    supervisor cron inotify-tools jq git rsync wget patch tar bzip2 unzip openssh-client \
    nginx vim curl mysql-client libxext6 libxrender1 iputils-ping && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    rm -rf /var/lib/apt/lists/* /etc/php/5* /etc/php/7.0 /etc/nginx/sites*

ADD files /

EXPOSE 80 443

VOLUME ["/data"]

ENTRYPOINT ["/config/bootstrap.sh"]
