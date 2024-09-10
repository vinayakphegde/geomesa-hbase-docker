# HBase in Docker

FROM registry.access.redhat.com/ubi8/openjdk-11
USER root
COPY *.sh /build/

ENV HBASE_LIB=/opt/hbase/lib/
ENV HADOOP_CONF_DIR=/opt/hbase/conf
ENV HBASE_CONF_DIR="$HADOOP_CONF_DIR"

ENV HBASE_USER=hbase

RUN mkdir -p "$HBASE_LIB" "$HADOOP_CONF_DIR"

ADD hbase-*-bin.tar.gz /

RUN /build/prepare.sh && \
    cd /opt/hbase && /build/build-hbase.sh \
    cd / && /build/cleanup-hbase.sh  && /build/geomesa-setup.sh && rm -rf /build

VOLUME /data

ADD ./hbase-site.xml /opt/hbase/conf/hbase-site.xml

ADD ./zoo.cfg /opt/hbase/conf/zoo.cfg

ADD ./hbase-start /opt/hbase-start

RUN set -x \
	&& useradd $HBASE_USER \
    && [ `id -u $HBASE_USER` -eq 1000 ] \
    && [ `id -g $HBASE_USER` -eq 1000 ] \
        && mkdir -p /opt/hbase/bin/../logs \
        && chown -R $HBASE_USER:$HBASE_USER  /opt

# Ensure the HBase user owns the /data directory
RUN mkdir /data && chown -R $HBASE_USER:$HBASE_USER /data

# Hbase REST port
EXPOSE 8000
# REST API
EXPOSE 8080
# REST Web UI at :8085/rest.jsp
EXPOSE 8085
# Thrift API
EXPOSE 9090
# Thrift Web UI at :9095/thrift.jsp
EXPOSE 9095
# HBase's Embedded zookeeper cluster
EXPOSE 2181
# HBase Master web UI at :16010/master-status;  ZK at :16010/zk.jsp
EXPOSE 16010
# Hbase RS port for clients
EXPOSE 16020

USER $HBASE_USER

ENTRYPOINT ["/opt/hbase-start"]
