sdk use java 11.0.16-amzn

pyenv local 3.7.17

export SPARK_HOME=/Users/vhegde/Downloads/HAC-693/spark-3.5.2-bin-hadoop3-scala2.13
export PYSPARK_PYTHON=python3
export GEOMESA_HOME=/Users/vhegde/scratchpad/geomesa2/geomesa-hbase_2.13-5.0.1
export HBASE_HOME=/Users/vhegde/work/OpDB/hbase/main/upstream/hbase
export PATH=$SPARK_HOME/bin:$GEOMESA_HOME/bin:$HBASE_HOME/bin:$PATH
