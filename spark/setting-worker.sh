#!/bin/bash

sudo apt-get update
sudo apt install openssh-server openssh-client -y
sudo apt install net-tools

sudo sed -i "/PasswordAuthentication/ c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo sed -i "/PermitRootLogin/ c\PermitRootLogin yes" /etc/ssh/sshd_config
sudo systemctl restart sshd

cat <<EOF > ~/.bash_profile
source ~/.bashrc
EOF

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
./aporrima/spark/install-python.sh