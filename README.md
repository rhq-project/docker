RHQ (without DB) contianer repository

To build and run rhq docker container:

1. Install docker-io $ yum -y install docker-io 
2. Build rhq image from Dockerfile $ ./build.sh 
3. Run rhq image $ ./run.sh
4. Clean up running rhq container $  ./run.sh cleanup
5. Delete old/current rhq image $ ./run.sh purge

rhq should be linked to postgresql container 

 Launch Postgresql db
$ docker run -d --name rhq-psql vnguyen/rhq-psql
 
 Launch RHQ server
docker run -dPit --link rhq-psql:db --name rhq-server jboss/rhq

See also:
https://github.com/gkhachik/rhq-docker
https://github.com/vnugent/rhq-psql-docker
