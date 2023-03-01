#!/bin/bash

. /etc/os-release

#check os
if [ "$NAME" != "Ubuntu" ]; then
    echo "This script is for Ubuntu."
    exit
fi

# update repo JAVA, ssh, net-tools, sshpass 
sudo apt-get update
sudo apt install openjdk-11-jdk -y
sudo apt install openssh-server openssh-client -y
sudo apt install net-tools
sudo apt-get install sshpass


