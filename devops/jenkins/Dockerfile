ARG JENKINS_VERSION

FROM jenkins/jenkins:${JENKINS_VERSION}

COPY ref/init.groovy.d /usr/share/jenkins/ref/init.groovy.d/

COPY ref/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
