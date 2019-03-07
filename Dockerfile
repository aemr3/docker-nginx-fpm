FROM alpine:3.7

RUN \
    apk add --no-cache --virtual .build-deps git file re2c autoconf make g++ php7-dev pcre-dev && \
    git clone --depth=1 -b v1.5 https://github.com/mongodb/mongo-php-driver.git /tmp/php-mongodb && \
    cd /tmp/php-mongodb && \
    git submodule update --init && \
    phpize && ./configure --prefix=/usr && make && make install && \
    cd .. && rm -rf /tmp/php-mongodb/ && \
    echo 'extension=mongodb.so' >> /etc/php7/conf.d/mongodb.ini && \
    apk del .build-deps

FROM alpine:3.7

ENV NGINX_GENERATE_DEFAULT_VHOST false
ENV NGINX_RELOAD_CONFIG true
ENV NGINX_INSTALL_DEFAULT_VHOST_FILES false
ENV NGINX_DEFAULT_VHOST_ROOT_PATH /data/www/default
ENV NGINX_ENABLE_REAL_IP false
ENV NGINX_REAL_IP_FROM 0.0.0.0/0
ENV NGINX_REAL_IP_HEADER X-Forwarded-For
ENV STATUS_PAGE_ALLOWED_IP 127.0.0.1

RUN \
    apk --no-cache add bash nginx supervisor curl wget tar bzip2 unzip inotify-tools vim mysql-client \
    php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl php7-zlib php7-xml php7-phar php7-tokenizer php7-fileinfo php7-intl \
    php7-dom php7-simplexml php7-xmlreader php7-xmlwriter php7-ctype php7-mbstring php7-gd php7-imagick php7-bcmath php7-pdo \
    php7-pdo_mysql php7-gmp php7-memcached php7-mcrypt php7-redis php7-opcache php7-pear php7-pspell php7-soap php7-zip && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD files /

COPY --from=0 /etc/php7/conf.d/mongodb.ini /etc/php7/conf.d/
COPY --from=0 /usr/lib/php7/modules/mongodb.so /usr/lib/php7/modules/

EXPOSE 80 443

VOLUME ["/data"]

ENTRYPOINT ["/config/bootstrap.sh"]
