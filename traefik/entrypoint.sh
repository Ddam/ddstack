#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- traefik "$@"
fi

# if our command is a valid Traefik subcommand, let's invoke it through Traefik instead
# (this allows for "docker run traefik version", etc)
if traefik "$1" --help | grep -s -q "help"; then
    set -- traefik "$@"
fi

cd /ssl
if [ ! -e "./certs/traefik.cert.pem" ]; then

    SUBJECT="/C=FR/ST=Calvados/L=Caen/O=Project SAS/OU=IT/CN=traefik"

    echo "Generate key..."
    openssl genrsa -out ./private/traefik.key.pem 2048
    chmod 666 ./private/traefik.key.pem

    echo "Generate autosigned certificate..."
    openssl req -x509 -key ./private/traefik.key.pem -days 375 -new -sha256 -out ./certs/traefik.cert.pem -subj "${SUBJECT}"
    echo "OK"
fi;
cd ~

exec "$@"
