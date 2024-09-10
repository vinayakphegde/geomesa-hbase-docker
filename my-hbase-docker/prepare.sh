. /build/config.sh

microdnf update && microdnf install git unzip wget hostname
cd /opt/

ls /hbase-*-*/*

mv /hbase-*-*/* hbase
rm -rf /hbase-*-*