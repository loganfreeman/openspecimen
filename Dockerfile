FROM jboss/wildfly:latest
#FROM arungupta/wildfly-centos

ADD customization /opt/jboss/wildfly/customization/
RUN chown -R root: /opt/jboss/wildfly/customization/execute.sh

CMD ["/opt/jboss/wildfly/customization/execute.sh"]
