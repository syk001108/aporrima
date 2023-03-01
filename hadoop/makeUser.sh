#!/bin/bash

# checking hadoop is existed
a=$(cat /etc/passwd | grep hadoop)
if [ "$a" != "" ]; then
	echo "exists user hadoop, delete and remake"
	sudo userdel -rf hadoop
fi

#make hadoop user
sudo useradd -m hadoop
echo 'hadoop:hadoop' | sudo chpasswd
sudo chown hadoop:hadoop /home/hadoop
sudo usermod -s /bin/bash hadoop
