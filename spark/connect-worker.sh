#!/bin/bash

HOSTNAME=$(hostname)

ssh-keygen -t rsa -C "$HOSTNAME" -f ~/.ssh/id_rsa -q -N "" && cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub  
chmod 644 ~/.ssh/authorized_keys
chmod 644 ~/.ssh/known_hosts
cat /etc/hosts >> host.txt

cnt=0
for i in $(sed -n '/spark/p' /etc/hosts)
do
	cnt=$(($cnt+1))
	if [[ "${i} " == *"$(hostname -I)"* ]] || [ $(($cnt%2)) == 0 ];then
		continue
	fi
	ssh-copy-id -o StrictHostKeyChecking=no -i /home/spark/.ssh/id_rsa.pub spark@$i
	scp -o StrictHostKeyChecking=no host.txt spark@$i:/home/spark/
	ssh -o StrictHostKeyChecking=no spark@$i "sudo cp host.txt /etc/hosts"
done