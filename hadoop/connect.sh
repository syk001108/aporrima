#!/bin/bash

cd /home/hadoop
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

cnt=0
for i in $(sed -n '/hd/p' /etc/hosts)
do
	cnt=$(($cnt+1))
	if [[ "${i} " == *"$(hostname -I)"* ]] || [ $(($cnt%2)) == 0 ];then
		continue
	fi
	sshpass -p hadoop ssh-copy-id -i /home/hadoop/.ssh/id_rsa.pub -o StrictHostKeyChecking=no hadoop@$i
done
