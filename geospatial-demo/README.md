# GeoMesa-HBase Integration POC

## Overview
This project demonstrates the integration of GeoMesa with HBase for handling large-scale geospatial data. It enables efficient querying and near real-time processing of spatial and temporal datasets. The goal is to showcase how GeoMesa can be easily integrated with HBase to support scalable geospatial analytics with strong consistency and performance.

## Demo Overview
### Setup
- Containerize GeoMesa and HBase services.
- Run a demo application using Jupyter Notebook.

### Data
- **Airports dataset** with location coordinates.
- **Simulated drone data**, capturing real-time drone movements.

### Demo Objective
- Detect drones flying within an N km radius of any airport.
- Use GeoMesa’s spatial queries over HBase to track drones and issue alerts if they enter restricted airspace.

### Results
- **Track Drone Trajectories**: Analyze drone movement patterns.
- **Near Real-Time Monitoring**: Detect drones entering restricted airspace within seconds.
- **Scalability**: Handle millions of geospatial data points efficiently using HBase.

## How to Run the Project
### Prerequisites
1. Download and extract Spark in the project root directory:
   ```bash
   wget https://downloads.apache.org/spark/spark-3.5.2/spark-3.5.2-bin-hadoop3-scala2.13.tgz
   tar -xvzf spark-3.5.2-bin-hadoop3-scala2.13.tgz
   ```
2. Download and extract GeoMesa-HBase, then copy the GeoMesa Spark runtime JARs to the project root folder:
   ```bash
   wget https://github.com/locationtech/geomesa/releases/download/geomesa-${GEOMESA_VERSION}/geomesa-hbase_2.13-${GEOMESA_VERSION}-bin.tar.gz
   tar -xvzf geomesa-hbase_2.13-${GEOMESA_VERSION}-bin.tar.gz
   cp geomesa/geomesa-hbase/geomesa-hbase-spark-runtime-hbase2/target/geomesa-hbase-spark-runtime-hbase2_2.13-5.0.2-SNAPSHOT.jar .
   ```
3. Start the HBase container:
   ```bash
   docker-compose up -d
   ```
4. Run the Spark setup script:
   ```bash
   source setup-spark.sh
   ```
5. Start Jupyter Notebook:
   ```bash
   jupyter notebook
   ```
6. Open `geomesa-spark.ipynb` and follow the steps.

## References
- [HBase](https://hbase.apache.org/)
- [GeoMesa](https://www.geomesa.org/)
- [GeoMesa HBase Quickstart](https://www.geomesa.org/documentation/stable/tutorials/geomesa-quickstart-hbase.html)
- [GeoMesa Spark Tutorial](https://www.geomesa.org/documentation/stable/tutorials/spark.html)
- [GeoServer](https://geoserver.org/)