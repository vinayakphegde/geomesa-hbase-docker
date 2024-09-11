ARG BASE_IMAGE=registry.access.redhat.com/ubi8/openjdk-11
FROM ${BASE_IMAGE}

ARG GEOSERVER_VERSION=2.24.4
ARG GEOMESA_VERSION=5.0.1
ARG HBASE_VERSION=2.5.8

USER root

# Set environment variables
ENV GEOSERVER_HOME=/usr/share/geoserver
ENV GEOMESA_HOME=/opt/geomesa-hbase
ENV HBASE_VERSION=${HBASE_VERSION}-hadoop3

# Install necessary packages
RUN microdnf update -y && microdnf install -y git unzip wget hostname && microdnf clean all

# Download and install GeoServer
RUN wget "https://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-bin.zip" -O geoserver.zip \
  && unzip geoserver.zip -d ${GEOSERVER_HOME} \
  && rm geoserver.zip

# Download and install GeoMesa HBase
RUN wget "https://github.com/locationtech/geomesa/releases/download/geomesa-${GEOMESA_VERSION}/geomesa-hbase_2.13-${GEOMESA_VERSION}-bin.tar.gz" -O geomesa-hbase.tar.gz \
    && tar -xzf geomesa-hbase.tar.gz -C /opt \
    && rm geomesa-hbase.tar.gz \
    && ln -s /opt/geomesa-hbase_2.13-${GEOMESA_VERSION} ${GEOMESA_HOME} \
    && sed -i 's/hbase_install_version="[^"]*"/hbase_install_version="'${HBASE_VERSION}'"/' ${GEOMESA_HOME}/conf/dependencies.sh \
    && chmod +x ${GEOMESA_HOME}/bin/install-dependencies.sh \
    && ${GEOMESA_HOME}/bin/install-dependencies.sh

# Install GeoMesa plugins in GeoServer
RUN mkdir -p ${GEOSERVER_HOME}/webapps/geoserver/WEB-INF/lib/ \
    && tar -xzf ${GEOMESA_HOME}/dist/gs-plugins/geomesa-hbase-gs-plugin_2.13-${GEOMESA_VERSION}-install.tar.gz -C ${GEOSERVER_HOME}/webapps/geoserver/WEB-INF/lib/ \
    && cp ${GEOMESA_HOME}/lib/* ${GEOSERVER_HOME}/webapps/geoserver/WEB-INF/lib/

# Add HBase configuration
COPY ./hbase-site.xml ${GEOSERVER_HOME}/webapps/geoserver/WEB-INF/classes/

# Expose GeoServer's default port
EXPOSE 8080

# Start Geoserver and keep it running
ENTRYPOINT ["/bin/bash", "-c", "${GEOSERVER_HOME}/bin/startup.sh && tail -f /dev/null"]