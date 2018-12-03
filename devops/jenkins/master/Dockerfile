#ARG JENKINS_VERSION
#
#FROM jenkins/jenkins:${JENKINS_VERSION}
#
#COPY ref/init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/
#COPY ref/plugins.txt /usr/share/jenkins/ref/plugins.txt
#
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt


FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install -y \
    make \
    gettext-base \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository \
          "deb [arch=amd64] https://download.docker.com/linux/debian \
          $(lsb_release -cs) \
          stable" \
    && apt-get update && apt-get install -y docker-ce \
    && usermod -aG docker jenkins

COPY ref/init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/
COPY ref/plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER jenkins
