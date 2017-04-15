FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV NGINX_GENERATE_DEFAULT_VHOST false
ENV STATUS_PAGE_ALLOWED_IP 127.0.0.1

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    php-cli php-fpm php-curl php-bcmath php-gd php-geoip php-gmp php-imagick php-intl \
    php-json php-mbstring php-memcached php-mcrypt php-mysql php-redis php7.1-opcache \
    php-pear php-pspell php-soap php-xml php-zip \
    supervisor inotify-tools jq git rsync wget patch tar bzip2 unzip openssh-client \
    nginx vim curl mysql-client libxrender1 libxext6 && \
    echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    rm -rf /var/lib/apt/lists/* /etc/php/5* /etc/php/7.0 /etc/nginx/sites*

ADD files /

EXPOSE 80 443

VOLUME ["/data"]

ENTRYPOINT ["/config/bootstrap.sh"]
