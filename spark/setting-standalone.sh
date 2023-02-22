#!/bin/bash

MASTER_IP=$(/sbin/ifconfig | grep '\<inet\>' | sed -n '1p' | tr -s ' ' | cut -d ' ' -f3 | cut -d ':' -f2)
MASTER_HOST=$(hostname)

sudo mkdir /home/spark/logs

cp spark/conf/spark-defaults.conf.template spark/conf/spark-defaults.conf
cat <<EOF | sudo tee ./spark-defaults.conf
spark.master                     spark://$MASTER_IP:7077
spark.serializer                 org.apache.spark.serializer.KryoSerializer
spark.eventLog.enabled           true
spark.eventLog.dir               /home/spark/logs
EOF

cp spark-env.sh.template spark-env.sh
cat <<EOF | sudo tee ./spark-env.sh
export SPARK_MASTER_IP='$MASTER_IP'
export SPARK_MASTER=$MASTER_HOST
EOF

cat <<EOF | sudo tee -a /etc/hosts
$MASTER_IP      $MASTER_HOST
EOF

$SPARK_HOME/sbin/start-master.sh
$SPARK_HOME/sbin/start-worker.sh spark://$MASTER_IP:7077

