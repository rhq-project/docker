#!/bin/bash
# Credit: https://github.com/shipyard/shipyard-deploy/, https://github.com/vnugent/rhq-psql-docker
usage() {
        echo "Usage: [-e] [-h] [action]" 1>&2;
        echo "    e: eap6, h: help" 1>&2;
        echo "    action: cleanup/purge" 1>&2;
        exit 1;
 }

INTERACTIVE="false"
DOCKER_RHQ_AGENT_HOME="/opt/rhq-agent"
SERVER=${RHQ_PORT_7080_TCP_ADDR:-}
while getopts ":eh" o; do
    case "${o}" in
        e)
            EAP_APP="true"
            ;;
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

ACTION=${1}


function cleanup {
    for CNT in rhq_server rhq_db rhq_nodb
    do
	docker kill $CNT > /dev/null 2>&1
	docker rm $CNT > /dev/null 2>&1
    done
}

function purge {
    cleanup
	docker rmi vnguyen/rhq-psql > /dev/null 2>&1
	docker rmi ahovsepy/rhq-nodb > /dev/null 2>&1
	docker rmi jboss/rhq > /dev/null 2>&1
}



if [ "$ACTION" = "cleanup" ] ; then
    cleanup
    echo "JON Server stack removed"
elif [ "$ACTION" = "purge" ] ; then
    echo "Removing JON Server images.  This could take a moment..."
    purge
else
    echo "Start Postgres container on host.  This may take a moment the first time..."
	db=$(docker run -i -t -d --name rhq_db vnguyen/rhq-psql)
    echo $db
    echo "Start JON container on host"
	rhq=$(docker run -i -t -d -p 7080:7080  --name rhq_server --link rhq_db:db  ahovsepy/rhq-nodb)
    echo $rhq


    echo "Waiting for JON server to start..."

    echo "You should be able to login JON with rhqadmin:rhqadmin  at http://<your docker host ip>:7080"

    exit 0
fi
