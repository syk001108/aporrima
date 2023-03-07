#!/bin/bash

if [ $# -eq 0 ];then
    echo "Please Input ip address"
    exit 0
fi

all=""
num=0
for i in $@
do
    num=$(($num+1))
    if [ "$num" == "1" ]; then
        all+="${i} "
        continue
    fi
    all+="${i} ubuntu "
done
# remove space
all=${all::-1}

./aporrima/hadoop/step1to3.sh $all


num=0
passwd="ubuntu"
for i in $@
do
    if [ "$num" == "0" ]; then
        num=$(($num+1))
        continue
    fi
    sshpass -p $passwd ssh ubuntu@$i -o StrictHostKeyChecking=no "sudo apt-get install git"
    sshpass -p $passwd ssh ubuntu@$i -o StrictHostKeyChecking=no "git clone https://github.com/boanlab/aporrima.git; ./aporrima/hadoop/step1to3.sh $all"
done


# connect NameNode
sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd; git clone https://github.com/boanlab/aporrima.git; ./aporrima/hadoop/connect.sh"


# connect DataNode
num=0
for i in $@
do
    if [ "$num" == "0" ]; then
        num=$(($num+1))
        continue
    fi
    sshpass -p hadoop ssh hadoop@$i -o StrictHostKeyChecking=no -t "cd; git clone https://github.com/boanlab/aporrima.git; ./aporrima/hadoop/connect.sh"
done



echo "hadoop" | su - hadoop -c "cd; ./aporrima/hadoop/installHadoop.sh; source ~/.bashrc;"

./aporrima/hadoop/inputProfile.sh

sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd ~; pwd; source ~/.bashrc; ./aporrima/hadoop/setHadoop.sh"
