#FROM jenkins/jenkins:2.60.3 これはだめだった
#FROM jenkins/jenkins:latest
#FROM jenkins/jenkins:lts
FROM jenkins/jenkins:2.204.1

USER root

COPY init.groovy.d/* /usr/share/jenkins/ref/init.groovy.d/
#RUN mkdir -p /usr/share/jenkins/ref/plugins
# COPY plugins/* /usr/share/jenkins/ref/plugins/
# add jenkins user
RUN mkdir /home/jenkins && chown jenkins:jenkins /home/jenkins && usermod -d /home/jenkins jenkins

# add docker group
# ARG DOCKER_GROUP_ID
# RUN groupadd -g ${DOCKER_GROUP_ID} docker && usermod -aG ${DOCKER_GROUP_ID} jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# ENV JAVA_OPTS="-Duser.timezone=Asia/Tokyo -Djenkins.install.runSetupWizard=false"
ENV JAVA_OPTS="-Duser.timezone=Asia/Tokyo"
# # install docker, docker-compose
# ARG DOCKER_VERSION=18.09.1
# RUN curl -fL -o docker.tgz "https://download.docker.com/linux/static/test/x86_64/docker-$DOCKER_VERSION.tgz" && \
#     tar --strip-component=1 -xvaf docker.tgz -C /usr/bin

# RUN curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

USER jenkins


