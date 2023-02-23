#!/bin/bash

sudo apt-get update
sudo apt install openssh-server openssh-client -y
sudo apt install net-tools -y

sudo sed -i "/PasswordAuthentication/ c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo sed -i "/PermitRootLogin/ c\PermitRootLogin yes" /etc/ssh/sshd_config
sudo systemctl restart sshd

./aporrima/spark/add-spark-user.sh
echo -n "spark" | su - spark -c "git clone https://github.com/boanlab/aporrima.git"
sleep 1

echo "Start install JAVA"
echo -n "spark" | su - spark -c "./aporrima/spark/install-java.sh"
sleep 1

echo "Start install Python3"
echo -n "spark" | su - spark -c "./aporrima/spark/install-python.sh"