#!/bin/bash
set -e

if [ ${HTTPD_FPM_MODE} = "1" ]; then
    sed -i -e 's/^#\(LoadModule .*mod_proxy_fcgi.so\)/\1/' /usr/local/apache2/conf/httpd.conf
fi;

if [ ${HTTPD_SSL_MODE} = "1" ]; then
    sed -i \
        -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
        -e 's/^#\(Include .*httpd-ssl-vhosts.conf\)/\1/' \
        -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
        -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
        -e 's/^#\(LoadModule .*mod_http2.so\)/\1/' \
        /usr/local/apache2/conf/httpd.conf

    if [ ${HTTPD_AUTOSIGNED_CERT} = "1" ] && [ ! -e "/etc/ssl/certs/${NAMESERVER}.cert.pem" ]; then
        cd /etc/ssl

        SUBJECT="/C=FR/ST=Calvados/L=Caen/O=Zephyr-web SAS/OU=IT/CN=${NAMESERVER}"

        echo "Generate key..."
        openssl genrsa -out ./private/${NAMESERVER}.key.pem 2048
        chmod 666 ./private/${NAMESERVER}.key.pem

        if [ -f "./certs/intermediate.cert.pem" ]; then
            if [ ! -e "./index.txt" ] || [ ! -e "./serial" ]; then
                touch ./index.txt
                echo 1000 > ./serial
            fi;

            echo "Generate CSR..."
            openssl req -config ./openssl.cnf -key ./private/${NAMESERVER}.key.pem -new -sha256 -out ./csr/${NAMESERVER}.csr.pem -subj "${SUBJECT}"
            chmod 666 ./csr/${NAMESERVER}.csr.pem

            echo "Generate server certificate..."
            openssl ca -batch -config ./openssl.cnf -extensions server_cert -days 375 -notext -md sha256 -in ./csr/${NAMESERVER}.csr.pem -out ./certs/${NAMESERVER}.cert.pem
            chmod 666 ./certs/${NAMESERVER}.cert.pem
            echo "OK"
        else
            echo "Generate autosigned certificate..."
            openssl req -x509 -key ./private/${NAMESERVER}.key.pem -days 375 -new -sha256 -out ./certs/${NAMESERVER}.cert.pem -subj "${SUBJECT}"
            echo "OK"
        fi;
    fi;
fi;

chown -R www-data. /var/www/html/public

exec "$@"
