ARG PHP_VERSION

FROM php:${PHP_VERSION}

LABEL maintainer="Derivery Damien <damien.derivery@zephyr-web.fr>"

ARG COMPOSER_VERSION

RUN apk --update add --no-cache --virtual .build-deps postgresql-dev icu-dev icu-libs libxml2-dev; \
    docker-php-ext-install intl xml pdo pdo_mysql opcache bcmath; \
    apk del .build-deps \
    && apk --update add --no-cache .persistent-deps wget git bash postgresql icu-libs acl \
    && apk --no-cache add --virtual .phpize-deps $PHPIZE_DEPS; \
        pecl install redis; \
        apk del .phpize-deps; \
        docker-php-ext-enable redis

RUN curl -s -f -L -o /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/b107d959a5924af895807021fcef4ffec5a76aa9/web/installer \
    && php -r " \
        \$signature = '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061'; \
        \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
        if (!hash_equals(\$signature, \$hash)) { \
            unlink('/tmp/installer.php'); \
            echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
            exit(1); \
        }" \
    && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
    && composer --ansi --version --no-interaction \
    && rm -rf /tmp/* /tmp/.htaccess

RUN mkdir -p /run/php

WORKDIR /var/www/html

RUN mkdir public \
  && touch public/index.php \
  && echo "<?php echo 'It works!' ?>" > public/index.php

# PHP Conf
COPY conf/php-fpm.conf /usr/local/etc/php-fpm.d/php-fpm.conf
COPY conf/www.conf /usr/local/etc/php-fpm.d/pool.d/www.conf
COPY conf/php.ini /usr/local/etc/php/conf.d/php.ini
