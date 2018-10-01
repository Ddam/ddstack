ARG TRAEFIK_VERSION

FROM traefik:${TRAEFIK_VERSION}

LABEL maintainer="Derivery Damien <damien.derivery@gmail.com>"

# Install necessary libraries
RUN apk --update add --no-cache --virtual .persistent-deps ca-certificates openssl \
    && rm -f /var/cache/apk/*

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
