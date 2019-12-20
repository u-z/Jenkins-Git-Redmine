# FROM jenkinsci/jenkins
FROM jenkins/jenkins:lts
MAINTAINER okazakiyuji
USER root
WORKDIR /tmp
RUN wget http://ftp.jaist.ac.jp/pub/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz && \
    tar xzf apache-maven-3.5.4-bin.tar.gz && \
    mv apache-maven-3.5.4 /opt/maven && \
    rm apache-maven-3.5.4-bin.tar.gz
ENV PATH $PATH:/opt/maven/bin
ENV JAVA_OPTS="-Duser.timezone=Asia/Tokyo"
COPY proxy-setting.sh /tmp/
RUN chmod a+x /tmp/proxy-setting.sh
# RUN chown jenkins.jenkins -R /opt/maven /etc/subversion /etc/mercurial/hgrc
USER jenkins
WORKDIR /tmp
