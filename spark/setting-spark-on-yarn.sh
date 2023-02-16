#!/bin/bash

MASTER_IP=$(/sbin/ifconfig | grep '\<inet\>' | sed -n '1p' | tr -s ' ' | cut -d ' ' -f3 | cut -d ':' -f2)
MASTER_CPU=$(grep 'cpu cores' /proc/cpuinfo | tail -1)

sudo mkdir /home/spark/logs
cd /$SPARK_HOME/conf

hdfs dfs -mkdir -p /user/spark/logs

cp spark-defaults.conf.template spark-defaults.conf
cat <<EOF | sudo tee ./spark-defaults.conf
spark.master                                    yarn
spark.serializer                                org.apache.spark.serializer.KryoSerializer
spark.driver.cores                              $MASTER_CPU
spark.executor.cores                            $MASTER_CPU
spark.eventLog.enabled                          true
spark.eventLog.dir                              hdfs:///user/spark/logs
spark.history.provider                          org.apache.spark.deploy.history.FsHistoryprovider
spark.yarn.historyServer.address                $MASTER_IP:18080
spark.yarn.appMasterEnv.PYSPARK_PYTHON          /usr/bin/python3
spark.yarn.appMasterEnv.PYSPARK_DRIVER_PYTHON   /usr/bin/python3
spark.driver.extraClassPath                     $SPARK_HOME/jars/*.jar
spark.executor.extraClassPath                   $SPARK_HOME/jars/*.jar
EOF

cp spark-env.sh.template spark-env.sh
cat <<EOF | sudo tee ./spark-env.sh
export HADOOP_CONF_DIR=/home/hadoop/hadoop-3.3.4/etc/hadoop/
export HADOOP_HOME=/home/hadoop/hadoop-3.3.4/
export PYSPARK_PYTHON=/usr/bin/python3
export PYSPARK_DRIVER_PYTHON=/usr/bin/python3
EOF

