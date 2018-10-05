ARG JENKINS_VERSION

FROM jenkins/jenkins:${JENKINS_VERSION}

ENV GLIBC 2.28-r0
ENV DOCKER 18.06.1-ce
ENV DOCKER_COMPOSE 1.22.0

USER root

# Install necessary libraries
RUN apk --update add --no-cache --virtual .persistent-deps gettext curl

# Install docker
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER}.tgz \
  && tar xzvf docker-${DOCKER}.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-${DOCKER}.tgz

# Install docker-compose
RUN apk add --update --no-cache openssl ca-certificates libgcc \
    && curl -fsSL -o /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && curl -fsSL -o glibc-${GLIBC}.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC}/glibc-${GLIBC}.apk \
    && apk add --no-cache glibc-${GLIBC}.apk \
    && ln -s /lib/libz.so.1 /usr/glibc-compat/lib/ \
    && ln -s /lib/libc.musl-x86_64.so.1 /usr/glibc-compat/lib \
    && ln -s /usr/lib/libgcc_s.so.1 /usr/glibc-compat/lib \
    && rm /etc/apk/keys/sgerrand.rsa.pub glibc-${GLIBC}.apk \
    && curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE}/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

COPY ref/jenkins.properties /var/jenkins_home/jenkins.properties

COPY ref/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

COPY ref/init.groovy.d /usr/share/jenkins/ref/init.groovy.d/
