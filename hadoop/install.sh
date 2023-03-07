#!/bin/bash

. /etc/os-release

#check os
if [ "$NAME" != "Ubuntu" ]; then
    echo "This script is for Ubuntu."
    exit
fi

# update repo JAVA, ssh, net-tools, sshpass 
sudo apt-get update
if [ "$(which java)" == "" ]; then
    sudo apt install openjdk-11-jdk -y
fi
if [ "$(which ssh)" == "" ]; then
    sudo apt install openssh-server openssh-client -y
fi
if [ "$(which netstat)" == "" ]; then
    sudo apt install net-tools
fi
if [ "$(which sshpass)" == "" ]; then
    sudo apt-get install sshpass
fi


