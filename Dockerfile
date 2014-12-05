# Use latest jboss/base-jdk:7 image as the base
FROM jboss/base-jdk:7

MAINTAINER  Armine Hovsepyan ahovsepy@redhat.com, Viet Nguyen vnguyen@redhat.com

# Set RHQ_VERSIOB env variable
ENV RHQ_VERSION 4.10

# Add rhq-nodb-deploy script to container
ADD rhq-nodb-deploy.sh /opt/jboss/rhq-nodb-deploy.sh

#Download rhq-server-RHQ_VERSION.0.zip , unzip it in /opt/jboss/ directory
RUN mkdir /opt/jboss/rhq-server ;\
    curl -s -L -o /opt/jboss/rhq-server/rhq-server-$RHQ_VERSION.0.zip  http://sourceforge.net/projects/rhq/files/rhq/rhq-$RHQ_VERSION/rhq-server-$RHQ_VERSION.0.zip/download  ;\
    unzip -q -d /opt/jboss/rhq-server/ /opt/jboss/rhq-server/rhq-server-$RHQ_VERSION.0.zip ;\
    rm /opt/jboss/rhq-server/rhq-server-$RHQ_VERSION.0.zip

# Set RHQ_HOME env variable
ENV RHQ_HOME /opt/jboss/rhq-server/rhq-server-$RHQ_VERSION.0

# expose 7080 (rhq server port)
EXPOSE 7080

# Install and start rhq server (with storage and agent) connected to "linked" rhq-psql (see vnguyen/rhq-psql image)
CMD ["/bin/bash", "/opt/jboss/rhq-nodb-deploy.sh", "RHQ_HOME=$RHQ_HOME"]
