#!/bin/bash
# Credit: https://github.com/shipyard/shipyard-deploy/
# See also: https://github.com/vnugent/rhq-psql-docker
echo "Setup starting ..."
DB_SERVER=${DB_PORT_5432_TCP_ADDR}

if [ ! -z $DB_SERVER ];
then
        echo "Configuring RHQ/JON Server to use '$DB_SERVER' database server instead of localhost"
        conn_url="s;^#\?rhq\.server\.database\.connection\-url=.*$;rhq.server.database.connection-url=jdbc:postgresql://${DB_SERVER}:5432/rhq;g"
        db_serv="s;^#\?rhq\.server\.database\.server\-name=.*$;rhq.server.database.server-name=${DB_SERVER};g"
        sed -i $db_serv ${RHQ_HOME}/bin/rhq-server.properties
        sed -i $conn_url ${RHQ_HOME}/bin/rhq-server.properties
fi
sed -i 's;^jboss\.bind\.address.*$;jboss.bind.address=0.0.0.0;g' ${RHQ_HOME}/bin/rhq-server.properties

${RHQ_HOME}/bin/rhqctl install 
${RHQ_HOME}/bin/rhqctl start

tail -F ${RHQ_HOME}/logs/server.log

