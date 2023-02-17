#!/bin/bash

a=$(cat /etc/passwd | grep hadoop)
if [ "$a" != "" ]; then
	echo "exists user hadoop"
	exit
fi

sudo useradd -m hadoop
echo 'hadoop:hadoop' | sudo chpasswd
sudo chown hadoop:hadoop /home/hadoop
sudo usermod -s /bin/bash hadoop
su hadoop
