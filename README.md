# HBase and GeoServer Docker Setup

This setup provides **HBase** and **GeoServer** with **GeoMesa HBase** integration using Docker.

## Prerequisites
- Install [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/).
- Ensure `.env` contains the correct image versions.

## Build Docker Images

1. **Update environment variables** in `.env` (if needed).
2. **Make the build script executable**:
   ```bash
   chmod +x build-images.sh
   ```  
3. **Build the images**:
   ```bash
   ./build-images.sh
   ```  

## Run Containers

Start **HBase** and **GeoServer**:
```bash
docker-compose up -d
```  

## Update `/etc/hosts`

To avoid hostname resolution issues when connecting to HBase from outside the container, add the following line to `/etc/hosts`:
```bash
127.0.0.1       localhost hbase-docker opdb-docker
```  

## Access Services

- **HBase UI**: [http://hbase-docker:16010/master-status](http://hbase-docker:16010/master-status)
- **GeoServer UI**: [http://localhost:8080/geoserver](http://localhost:8080/geoserver)

## Stop Containers

To stop and remove containers:
```bash
docker-compose down
```