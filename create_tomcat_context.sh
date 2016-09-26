#!/bin/bash

if [ -f /.tomcat_context_created ]; then
    echo "JNDI datasource already added in Tomcat context.xml"
    exit 0
fi

echo "=> add a JNDI datasource in Tomcat"
sed -i -r 's/<\/Context>//' ${CATALINA_HOME}/conf/context.xml
echo '<Resource name="jdbc/openspecimen" auth="Container" type="javax.sql.DataSource"' >> ${CATALINA_HOME}/conf/context.xml
echo 'maxTotal="100" maxIdle="30" maxWaitMillis="10000"' >> ${CATALINA_HOME}/conf/context.xml
echo 'username="root" password="pass22" driverClassName="com.mysql.jdbc.Driver"' >> ${CATALINA_HOME}/conf/context.xml
echo 'url="jdbc:mysql://db:3306/osdb"/>' >> ${CATALINA_HOME}/conf/context.xml
echo '</Context>' >> ${CATALINA_HOME}/conf/context.xml
echo "=> Done!"
touch /.tomcat_context_created
