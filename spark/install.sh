#!/bin/bash

sudo apt-get update
sudo apt install openssh-server openssh-client -y
sudo apt install net-tools -y

sudo sed -i "/PasswordAuthentication/ c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo sed -i "/PermitRootLogin/ c\PermitRootLogin yes" /etc/ssh/sshd_config
sudo systemctl restart sshd

./aporrima/spark/add-spark-user.sh
# echo -n "spark" | su - spark -c "git clone https://github.com/boanlab/aporrima.git"
echo -n "spark" | su - spark -c "git clone https://github.com/Apdul0329/aporrima.git"
sleep 1

echo "Start install JAVA"
echo -n "spark" | su - spark -c "./aporrima/spark/install-java.sh"

sleep 1

echo "Start install Python3"
echo -n "spark" | su - spark -c "./aporrima/spark/install-python.sh"

sleep 1

echo "Start install Spark"
echo -n "spark" | su - spark -c "./aporrima/spark/install-spark.sh"



echo "Please select a number that corresponds to the desired installation mode"
read -r -p "(1 : Local Standalone / 2 : Spark on YARN / 3 : Standalone Cluster) : " response
case $response in
    1)
        echo "Set up local standalone mode"
        echo -n "spark" | su - spark -c "./aporrima/spark/setting-standalone.sh"
        ;;
    2)
        echo "Set up Spark on YARN mode"
        echo -n "spark" | su - spark -c "./aporrima/spark/setting-spark-on-yarn.sh"
        ;;
    3)
        echo "Set up standalone cluster mode"
        ./aporrima/spark/add-host.sh
        echo -n "spark" | su - spark -c "./aporrima/spark/setting-standalone-cluster.sh"
        echo -n "spark" | su - spark -c "$SPARK_HOME/sbin/start-all.sh"
esac