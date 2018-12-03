FROM docker:dind

ARG JENKINS_AGENT_HOME

RUN addgroup -g 1000 1000 \
  && adduser -D -h /home/jenkins -u 1000 -G 1000 -s /bin/bash jenkins \
  && passwd -u jenkins

RUN apk update \
    && apk add --no-cache sudo bash openssh openjdk8 git subversion curl wget
RUN sed -i /etc/ssh/sshd_config \
        -e 's/#PermitRootLogin.*/PermitRootLogin no/' \
        -e 's/#RSAAuthentication.*/RSAAuthentication yes/'  \
        -e 's/#PasswordAuthentication.*/PasswordAuthentication no/' \
        -e 's/#SyslogFacility.*/SyslogFacility AUTH/' \
        -e 's/#LogLevel.*/LogLevel INFO/' \
    && mkdir /var/run/sshd \
    && echo "%1000 ALL=(ALL) NOPASSWD: /usr/local/bin/docker" >> /etc/sudoers

RUN delgroup ping \
    && addgroup -g 999 docker \
    && addgroup jenkins docker \
    && ln -s /usr/local/bin/docker /usr/bin/docker

WORKDIR ${JENKINS_AGENT_HOME}

COPY entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
