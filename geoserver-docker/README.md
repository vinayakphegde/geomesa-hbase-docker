# GeoServer & GeoMesa Docker Image

This Docker image provides a pre-configured **GeoServer** with **GeoMesa HBase** integration on Red Hat UBI 8 and OpenJDK 11.

## Summary
- Installs **GeoServer v2.24.4** and **GeoMesa v5.0.1**
- Configures GeoMesa HBase dependencies
- Adds necessary plugins for GeoServer to support GeoMesa
- Copies custom HBase configuration
- Exposes GeoServer on port **8080**

## Running the Container
```sh
docker run -d --name geoserver -p 8080:8080 your-image-name
```