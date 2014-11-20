rhq_nodb
========

RHQ (without DB) contianer repository

Demo how RHQ Dockerfile works https://plus.google.com/u/0/events/clp274bhmdfvi4ol7csh2fd7n38?authkey=CPGuh8eZtrG5oAE

To build and run rhq docker container:

1. Install docker-io $ yum -y install docker-io 
2. Build rhq image from Dockerfile $ ./build.sh 

rhq should be linked to postgresql container 

1. docker run -i -t -d –name rhq_db vnguyen/rhq-psql
2. docker run -i -t -d -p 7080:7080 –name rhq_server –link rhq_db:db rhqproject/rhq-nodb
