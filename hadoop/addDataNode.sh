#!/bin/bash

# add host /etc/hosts
cnt=$(sed -n '/hd/p' /etc/hosts)
cnt=${cnt: -1}
cnt=$(($cnt+1))
echo "$1 hdw$cnt" | sudo tee -a  /etc/hosts

# make all address
address=""
for i in $(sed -n '/hd/p' /etc/hosts)
do
    address+="${i} "
done
# remove space
address=${address::-1}


# datanode install+hostset+makeUserHadoop
sshpass -p $2 ssh ubuntu@$1 -o StrictHostKeyChecking=no "sudo apt-get install git" 
sshpass -p $2 ssh ubuntu@$1 -o StrictHostKeyChecking=no "git clone https://github.com/psy337337/aporrima.git; ./aporrima/hadoop/step1to3.sh $address"

# connect namenode & datanode
sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd; ssh-copy-id -i /home/hadoop/.ssh/id_rsa.pub hadoop@$1"

sshpass -p hadoop ssh hadoop@$1 -o StrictHostKeyChecking=no -t "cd; git clone https://github.com/psy337337/aporrima.git; ./aporrima/hadoop/connect.sh"


# send Hadoop Setting to datanode
sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd ~; pwd; source ~/.bashrc; ./aporrima/hadoop/setHadoop-addDataNode.sh"

