#!/bin/bash

MASTER_IP=$(/sbin/ifconfig | grep '\<inet\>' | sed -n '1p' | tr -s ' ' | cut -d ' ' -f3 | cut -d ':' -f2)
MASTER_HOST=spark-master

./aporrima/spark/connect-worker.sh

sudo mkdir /home/spark/logs

cp spark/conf/spark-defaults.conf.template spark/conf/spark-defaults.conf
cat <<EOF | sudo tee ./spark-defaults.conf
spark.master                     spark://$MASTER_IP:7077
spark.serializer                 org.apache.spark.serializer.KryoSerializer
spark.eventLog.enabled           true
spark.eventLog.dir               /home/spark/logs
EOF

cp spark/conf/spark-env.sh.template spark/conf/spark-env.sh
cat <<EOF | sudo tee ./spark-env.sh
export SPARK_MASTER_IP='$MASTER_IP'
export SPARK_MASTER=$MASTER_HOST
EOF

cp spark/conf/workers.template spark/conf/workers
for i in $(sed -n '/spark/p' /etc/hosts)
do
	if [[ "${i}" == *"worker"* ]];then
		echo $i > $SPARK_HOME/conf/workers
	fi
done

LINE_CNT=$(sed -n '/spark/p' /etc/hosts | wc -l)
for ((i=1; i<$LINE_CNT; i++))
do
	scp -r /home/spark/* spark@$i:/home/spark/
done