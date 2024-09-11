#!/bin/bash

# Load environment variables from .env file
set -a
. ./.env
set +a

# Check if required environment variables are set
if [ -z "$HBASE_IMAGE" ] || [ -z "$GEOSERVER_IMAGE" ]; then
    echo "Error: HBASE_IMAGE or GEOSERVER_IMAGE is not set in .env file."
    exit 1
fi

# Build HBase Docker image
echo "Building HBase Docker image: ${HBASE_IMAGE}"
docker build -t "${HBASE_IMAGE}" --build-arg HBASE_VERSION="${HBASE_VERSION}" --build-arg GEOMESA_VERSION="${GEOMESA_VERSION}" ./hbase-docker

if [ $? -ne 0 ]; then
    echo "Error: Failed to build HBase Docker image."
    exit 1
else
    echo "HBase Docker image built successfully."
fi

# Build GeoServer Docker image
echo "Building GeoServer Docker image: ${GEOSERVER_IMAGE}"
docker build -t "${GEOSERVER_IMAGE}" --build-arg GEOSERVER_VERSION="${GEOSERVER_VERSION}" --build-arg GEOMESA_VERSION="${GEOMESA_VERSION}" --build-arg HBASE_VERSION="${HBASE_VERSION}" ./geoserver-docker

if [ $? -ne 0 ]; then
    echo "Error: Failed to build GeoServer Docker image."
    exit 1
else
    echo "GeoServer Docker image built successfully."
fi
