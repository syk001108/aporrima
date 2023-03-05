#!/bin/bash

MASTER_IP=$(/sbin/ifconfig | grep '\<inet\>' | sed -n '1p' | tr -s ' ' | cut -d ' ' -f3 | cut -d ':' -f2)
MASTER_CPU=$(grep 'cpu cores' /proc/cpuinfo | tail -1)

hdfs dfs -mkdir -p /user/hadoop/logs

cp spark/conf/spark-defaults.conf.template spark/conf/spark-defaults.conf
cat <<EOF | sudo tee spark/conf/spark-defaults.conf
spark.master                                    yarn
spark.serializer                                org.apache.spark.serializer.KryoSerializer
spark.driver.cores                              1
spark.executor.cores                            1
spark.eventLog.enabled                          true
spark.eventLog.dir                              hdfs:///user/hadoop/logs
spark.history.provider                          org.apache.spark.deploy.history.FsHistoryprovider
spark.yarn.historyServer.address                $MASTER_IP:18080
spark.yarn.appMasterEnv.PYSPARK_PYTHON          /usr/bin/python3
spark.yarn.appMasterEnv.PYSPARK_DRIVER_PYTHON   /usr/bin/python3
spark.driver.extraClassPath                     /spark/jars/*.jar
spark.executor.extraClassPath                   /spark/jars/*.jar
EOF

cp spark/conf/spark-env.sh.template spark/conf/spark-env.sh
cat <<EOF | sudo tee spark/conf/spark-env.sh
export HADOOP_CONF_DIR=/home/hadoop/hadoop-3.3.4/etc/hadoop/
export HADOOP_HOME=/home/hadoop/hadoop-3.3.4/
export PYSPARK_PYTHON=/usr/bin/python3
export PYSPARK_DRIVER_PYTHON=jupyter
EOF

