ARG REDIS_VERSION

FROM redis:${REDIS_VERSION}

LABEL maintainer="Derivery Damien <damien.derivery@gmail.com>"

# Install necessary libraries
RUN apk --update add --no-cache --virtual .persistent-deps bash \
    && rm -f /var/cache/apk/*

ARG REDIS_PASSWORD

COPY scripts/mass_insertion.sh /usr/local/bin/mass_insertion
RUN sed -i "s/REDIS_PASSWORD/${REDIS_PASSWORD}/g" /usr/local/bin/mass_insertion

RUN chmod +x /usr/local/bin/mass_insertion

CMD ["redis-server"]
