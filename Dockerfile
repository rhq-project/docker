FROM jboss/base-jdk:7

MAINTAINER  Armine Hovsepyan ahovsepy@redhat.com, Viet Nguyen vnguyen@redhat.com

USER root

RUN yum install -y docker-io

ADD rhq-docker-deploy.sh /usr/local/bin/rhq-docker-deploy.sh

ENTRYPOINT ["/usr/local/bin/rhq-docker-deploy.sh"]
