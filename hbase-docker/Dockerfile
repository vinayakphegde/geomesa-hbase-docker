ARG BASE_IMAGE=registry.access.redhat.com/ubi8/openjdk-11
FROM ${BASE_IMAGE}

ARG HBASE_VERSION=2.5.8
ARG GEOMESA_VERSION=5.0.1

USER root

# Set environment variables
ENV HBASE_HOME=/opt/hbase

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk \
    HBASE_USER=hbase \
    HBASE_CONF_DIR=${HBASE_HOME}/conf \
    HBASE_LIB_DIR=${HBASE_HOME}/lib \
    HBASE_LOGS_DIR=${HBASE_HOME}/logs \
    DATA_DIR=/data-store \
    GEOMESA_HOME=/opt/geomesa-hbase

# Install necessary packages
RUN INITRD=no DEBIAN_FRONTEND=noninteractive microdnf update -y && microdnf install -y unzip gzip wget hostname

# Download and Install HBase
RUN wget https://archive.apache.org/dist/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-hadoop3-bin.tar.gz \
    && tar -xzf hbase-${HBASE_VERSION}-hadoop3-bin.tar.gz -C /opt \
    && rm hbase-${HBASE_VERSION}-hadoop3-bin.tar.gz \
    && ln -s /opt/hbase-${HBASE_VERSION}-hadoop3 ${HBASE_HOME}

# Apply custom HBase build steps
RUN sed -i "s,^. export JAVA_HOME.*,export JAVA_HOME=$JAVA_HOME," ${HBASE_CONF_DIR}/hbase-env.sh \
    && sed -E -i 's/(.*)hbase\-daemons\.sh(.*zookeeper)/\1hbase-daemon.sh\2/g' ${HBASE_HOME}/bin/start-hbase.sh \
    && echo -e "JAVA_HOME=$JAVA_HOME\nexport JAVA_HOME\nexport PATH=$JAVA_HOME/jre/bin:$PATH" > /etc/profile.d/defaults.sh \
    && ln -sf ${HBASE_HOME}/bin/* /usr/bin

# Create HBase user
RUN useradd -u 1000 -m ${HBASE_USER} \
    && chown -R ${HBASE_USER}:${HBASE_USER} /opt \
    && mkdir "$DATA_DIR" && chown -R ${HBASE_USER}:${HBASE_USER} "$DATA_DIR"

# Copy configuration files
COPY hbase-site.xml ${HBASE_CONF_DIR}/hbase-site.xml
COPY zoo.cfg ${HBASE_CONF_DIR}/zoo.cfg

# Set up GeoMesa
RUN wget https://github.com/locationtech/geomesa/releases/download/geomesa-${GEOMESA_VERSION}/geomesa-hbase_2.13-${GEOMESA_VERSION}-bin.tar.gz \
    && tar -xzf geomesa-hbase_2.13-${GEOMESA_VERSION}-bin.tar.gz -C /opt \
    && rm geomesa-hbase_2.13-${GEOMESA_VERSION}-bin.tar.gz \
    && ln -s /opt/geomesa-hbase_2.13-${GEOMESA_VERSION} ${GEOMESA_HOME} \
    && cp ${GEOMESA_HOME}/dist/hbase/geomesa-hbase-distributed-runtime-hbase2_2.13-${GEOMESA_VERSION}.jar ${HBASE_LIB_DIR}

# Expose required ports for HBase and related services
EXPOSE 8000 8080 8085 9090 9095 2181 16000 16010 16020 16030

# Switch to the HBase user
USER ${HBASE_USER}

# Create necessary directories for HBase to run
RUN mkdir -p "$DATA_DIR"/hbase "$DATA_DIR"/run "$DATA_DIR"/logs

# Start HBase and keep it running
ENTRYPOINT ["/bin/bash", "-c", "${HBASE_HOME}/bin/start-hbase.sh && tail -f ${HBASE_LOGS_DIR}/*.log"]