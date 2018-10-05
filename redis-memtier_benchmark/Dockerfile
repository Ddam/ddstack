FROM alpine:3.7

# Install necessary libraries
RUN apk --update add --no-cache --virtual .persistent-deps libtool cmake make gcc g++ libc-dev zlib-dev libevent-dev pcre-dev autoconf automake git curl \
    && rm -f /var/cache/apk/*

ARG REDIS_MEMTIER_VERSION
ARG REDIS_SERVER
ARG REDIS_PASSWORD

RUN curl -L https://github.com/RedisLabs/memtier_benchmark/archive/${REDIS_MEMTIER_VERSION}.tar.gz  -o /tmp/memtier.tar.gz && \
    tar -C /tmp -xzvf /tmp/memtier.tar.gz && \
    cd /tmp/memtier_benchmark-${REDIS_MEMTIER_VERSION} && \
    autoreconf -ivf && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/memtier_benchmark-${REDIS_MEMTIER_VERSION}

COPY scripts/memtier_benchmark.sh /opt/memtier_benchmark
RUN sed -i "s/REDIS_SERVER/${REDIS_SERVER}/g" /opt/memtier_benchmark && \
    sed -i "s/REDIS_PASSWORD/${REDIS_PASSWORD}/g" /opt/memtier_benchmark && \
    chmod +x /opt/memtier_benchmark

WORKDIR /memtier_benchmark

CMD ["watch", "ls"]
