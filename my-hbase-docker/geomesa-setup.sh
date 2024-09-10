# Install GeoMesa HBase 5.0.1
GEOMESA_VERSION=5.0.1

wget https://github.com/locationtech/geomesa/releases/download/geomesa-${GEOMESA_VERSION}/geomesa-hbase_2.13-${GEOMESA_VERSION}-bin.tar.gz

tar -xzf geomesa-hbase_2.13-${GEOMESA_VERSION}-bin.tar.gz -C /opt

rm geomesa-hbase_2.13-${GEOMESA_VERSION}-bin.tar.gz \

ln -s /opt/geomesa-hbase_2.13-${GEOMESA_VERSION} /opt/geomesa-hbase

cp /opt/geomesa-hbase/dist/hbase/geomesa-hbase-distributed-runtime-hbase2_2.13-${GEOMESA_VERSION}.jar /opt/hbase/lib