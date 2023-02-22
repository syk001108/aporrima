#!/bin/bash

MASTER_IP=$(/sbin/ifconfig | grep '\<inet\>' | sed -n '1p' | tr -s ' ' | cut -d ' ' -f3 | cut -d ':' -f2)
MASTER_HOST=spark-master

cat <<EOF | sudo tee /etc/hosts
$MASTER_IP      $MASTER_HOST
EOF

echo "This script will set up /etc/hosts file"
read -r -p "Please input the number of walker nodes: " NUM
for ((var=0 ; var < $NUM ; var++));
do
    read -r -p "Please input IP: " IP
	WORKER_NUMBER=$(($var+1))
    HOST="spark-worker$WORKER_NUMBER"
    ./aporrima/spark/add-host.sh $HOST $IP
done 

cp ./aporrima/spark/connect-worker.sh /home/spark/
su - spark -c "./connect-worker.sh"

sudo mkdir /home/spark/logs
cd /$SPARK_HOME/conf

cp spark-defaults.conf.template spark-defaults.conf
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

cp workers.template workers
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