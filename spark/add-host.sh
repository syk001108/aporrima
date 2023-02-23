#!/bin/bash

MASTER_IP=$(/sbin/ifconfig | grep '\<inet\>' | sed -n '1p' | tr -s ' ' | cut -d ' ' -f3 | cut -d ':' -f2)
MASTER_HOST=spark-master
ETC_HOSTS=/etc/hosts
IP=$1

echo "This script will set up /etc/hosts file"
read -r -p "Please input the number of walker nodes: " NUM
NUM=$(($NUM+1))
echo $NUM
for ((var=0 ; var < $NUM ; var++));
do
    if [ $var -eq 0 ]; then
        cat <<EOF | sudo tee /etc/hosts
$MASTER_IP      $MASTER_HOST
EOF
    else
        read -r -p "Please input IP: " IP
        HOSTNAME="spark-worker$var"
        HOSTS_LINE="$IP\t$HOSTNAME"

        if [ -n "$(grep $HOSTNAME /etc/hosts)" ]; then
            echo "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
            ./aporrima/spark/remove-host.sh $HOSTNAME
        else
            echo "Adding $HOSTNAME to your $ETC_HOSTS"
            sudo -- sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts"
        fi
    # ./aporrima/spark/add-host.sh $HOST $IP
    fi
done 