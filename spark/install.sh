#!/bin/bash

sudo chmod -R 777 ./aporrima
sudo apt-get update
sudo apt install openssh-server openssh-client -y
sudo apt install net-tools

sudo sed -i "/PasswordAuthentication/ c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo sed -i "/PermitRootLogin/ c\PermitRootLogin yes" /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "DISCLAIMER: This is an automated script for installing Spark but you should feel responsible for what you're doing!"
echo "This script will install Spark to your home directory, modify your PATH, and add environment variables to your SHELL config file"
read -r -p "Proceed? [y/N] " response
if [[ ! $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Aborting..."
    exit 1
fi

echo "This script will create a new Spark user"
read -r -p "Proceed? [y/N] " response
if [[ ! $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Aborting..."
    exit 1
fi
./aporrima/spark/add-spark-user.sh

sleep 1

echo "This script will install a JAVA&PYTHON3 for Spark"
read -r -p "Proceed? [y/N] " response
if [[ ! $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Aborting..."
    exit 1
fi

echo "Start install JAVA"
./aporrima/spark/install-java.sh

sleep 1

echo "Start install Python3"
./aporrima/spark/install-java.sh

sleep 1

echo "Start install Spark"
./aporrima/spark/install-spark.sh

echo "Please select a number that corresponds to the desired installation mode"
read -r -p "(1 : Local Standalone / 2 : Spark on YARN / 3 : Standalone Cluster) : " response
case $response in
    1)
        echo "Set up local standalone mode"
        ./aporrima/spark/setting-standalone.sh
        ;;
    2)
        echo "Set up Spark on YARN mode"
        ./aporrima/spark/setting-spark-on-yarn.sh
        ;;
    3)
        echo "Set up standalone cluster mode"
        ./aporrima/spark/setting-standalone-cluster.sh
        $SPARK_HOME/sbin/start-all.sh
esac

