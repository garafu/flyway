FROM centos:8.2.2004

COPY  flyway.conf /root

RUN  \
# install java \
curl -L -o jre-8u251-linux-x64.rpm https://javadl.oracle.com/webapps/download/AutoDL?BundleId=242049_3d5a2bb8f8d4428bbe94aed7ec7ae784; \
yum install -y jre-8u251-linux-x64.rpm; \
rm jre-8u251-linux-x64.rpm; \
yum clean all; \
# install flyway \
curl -LO https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/6.4.4/flyway-commandline-6.4.4-linux-x64.tar.gz; \
tar -xvf flyway-commandline-6.4.4-linux-x64.tar.gz; \
mv flyway-6.4.4 /root; \
ln -s /root/flyway-6.4.4/flyway /usr/local/bin; \
mv -f /root/flyway.conf /root/flyway-6.4.4/conf/flyway.conf; \
rm flyway-commandline-6.4.4-linux-x64.tar.gz;

VOLUME  ["/root/flyway-6.4.4/sql"]

ENV URL=jdbc:mysql://<host>:<port>/<database>
ENV USER=user
ENV PASSWORD=password
ENV SCHEMAS=sample
ENV TABLE=z_schema_history
