#!/bin/bash

ssh-keygen -t rsa -P “”
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/authorized_keys

cnt=0
for i in $(sed -n '/spark/p' /etc/hosts)
do
	cnt=$(($cnt+1))
	if [[ "${i} " == *"$(hostname -I)"* ]] || [ $(($cnt%2)) == 0 ];then
		continue
	fi
	ssh-copy-id -i /home/spark/.ssh/id_rsa.pub spark@$i
	cat /etc/hosts >> host.txt
	scp host.txt spark@$i:/home/spark/
	ssh spark@$i "sudo cp host.txt /etc/hosts"
done