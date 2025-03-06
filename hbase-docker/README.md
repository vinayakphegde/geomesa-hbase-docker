# HBase & GeoMesa Docker Image  

This Docker image provides a pre-configured environment for running **Apache HBase** with **GeoMesa** on Red Hat UBI 8 and OpenJDK 11.  

## Features  
- Installs **HBase v2.5.8** and **GeoMesa v5.0.1**  
- Configures environment variables for HBase and GeoMesa  
- Includes essential utilities (`unzip`, `gzip`, `wget`, `hostname`)  
- Copies custom HBase configuration files (`hbase-site.xml`, `zoo.cfg`)  
- Exposes required ports for HBase and ZooKeeper  
- Runs HBase as a non-root user (`hbase`)  

## Environment Variables  
| Variable       | Description                              | Default Value |
|---------------|------------------------------------------|--------------|
| `HBASE_HOME`  | HBase installation directory            | `/opt/hbase` |
| `JAVA_HOME`   | Java installation path                  | `/usr/lib/jvm/java-11-openjdk` |
| `HBASE_USER`  | User running HBase                      | `hbase` |
| `DATA_DIR`    | Root directory for HBase data storage   | `/data-store` |
| `GEOMESA_HOME`| GeoMesa installation directory          | `/opt/geomesa-hbase` |

## Exposed Ports  
- 2181 (ZooKeeper)  
- 8000, 8080, 8085, 9090, 9095 (HBase services)  
- 16000, 16010, 16020, 16030 (HBase Master/RegionServer)  

## Running the Container  
```sh
docker run -d --name hbase-geomesa-container -p 16010:16010 -p 2181:2181 your-image-name
```

## Notes  
- The container starts HBase automatically and keeps it running.  
- Logs are available in `/data-store/logs`.  
- Ensure the correct HBase and GeoMesa versions are set before building the image.
