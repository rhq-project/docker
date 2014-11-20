FROM jboss/base-jdk:7

MAINTAINER  Armine Hovsepyan ahovsepy@redhat.com

USER root

RUN yum install -y unzip wget

RUN wget http://sourceforge.net/projects/rhq/files/rhq/rhq-4.12/rhq-server-4.12.0.zip/download  -O /opt/rhq-server-4.12.0.zip

ADD rhq-nodb-deploy.sh /usr/local/bin/rhq-nodb-deploy.sh

EXPOSE 7080

CMD ["/usr/local/bin/rhq-nodb-deploy.sh"]
