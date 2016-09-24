FROM tifayuki/java:8
MAINTAINER Feng Honglin <hfeng@tutum.co>

RUN apt-get update && \
    apt-get install -yq --no-install-recommends wget pwgen ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_MINOR_VERSION 8.0.11
ENV CATALINA_HOME /tomcat

# INSTALL TOMCAT
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz && \
    mv apache-tomcat* tomcat

ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
RUN mkdir -p /usr/local/tomcat/data
RUN mkdir -p /usr/local/tomcat/plugins
COPY ./build/libs/openspecimen.war ${CATALINA_HOME}/webapps/
COPY ./antlr-2.7.7.jar ${CATALINA_HOME}/lib/
COPY ./mysql-connector-java-5.1.38-bin.jar ${CATALINA_HOME}/lib/
COPY ./slf4j-log4j12-1.7.12.jar ${CATALINA_HOME}/lib/

EXPOSE 8080
CMD ["/run.sh"]
