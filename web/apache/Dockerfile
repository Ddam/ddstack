ARG APACHE_VERSION

FROM httpd:${APACHE_VERSION}

LABEL maintainer="Derivery Damien <damien.derivery@zephyr-web.fr>"

# Install necessary libraries
RUN apk --update add --no-cache --virtual .persistent-deps ca-certificates openssl acl \
    && rm -f /var/cache/apk/*

# Apache Conf
COPY conf/httpd.conf /usr/local/apache2/conf/httpd.conf
COPY conf/httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf
COPY conf/httpd-vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf
COPY ssl /etc/ssl

COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

WORKDIR /var/www/html

RUN mkdir public \
  && touch public/index.php \
  && echo "<h1>It works!</h1>" > public/index.php

EXPOSE 80 443

ENTRYPOINT ["entrypoint"]

CMD ["httpd-foreground"]
