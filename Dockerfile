FROM 		tutum/tomcat:latest

MAINTAINER 	Shanhong

COPY 		./build/libs/openspecimen.war ${CATALINA_HOME}/webapps/
