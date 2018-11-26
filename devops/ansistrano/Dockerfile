FROM alpine:latest

LABEL maintainer="Derivery Damien <damien.derivery@gmail.com>"

RUN apk add --no-cache --virtual .persistent-deps \
        python \
        py-pip \
        openssl \
        ca-certificates \
        rsync \
        bash \
        openssh-client \
        sshpass
RUN apk add --no-cache --virtual .build-deps \
        python-dev \
        libffi-dev \
        openssl-dev \
        build-base \
    && pip install --upgrade \
        pip \
    && pip install \
        cffi \
        ansible \
    && apk del .build-deps
RUN mkdir -p /etc/ansible /etc/ansible/playbooks \
    && ssh-keygen -t rsa -b 4096 -C '' -f ~/.ssh/id_rsa

# Install Ansistrano role
RUN ansible-galaxy install --force ansistrano.deploy ansistrano.rollback

## Ansistrano user
RUN addgroup -S ansistrano
RUN adduser -S -D ansistrano -G ansistrano
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## Ansistrano folder
RUN mkdir /etc/ansistrano/
USER ansistrano
RUN mkdir -p ~/.ssh /etc/ansistrano/
RUN cd ~/.ssh && ssh-keygen -t rsa -b 4096 -C '' -f ~/.ssh/id_rsa
USER root
RUN chown ansistrano. -Rf /etc/ansistrano/

COPY conf/ansible.cfg /etc/ansible/ansible.cfg
COPY entrypoint.sh /usr/local/bin/docker-app-entrypoint
RUN chmod +x /usr/local/bin/docker-app-entrypoint

ENTRYPOINT ["/usr/local/bin/docker-app-entrypoint"]

CMD tail -f /dev/null
