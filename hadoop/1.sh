#!/bin/bash

if [ $# -eq 0 ];then
    echo "Please Input ip address"
    exit 0
fi

./aporrima/hadoop/step1to3.sh $@

#first time can't used sshpass


num=0
address=""
for i in $@
do
    num=$(($num+1))
    if [ "$(($num%2))" == "0" ]; then
        address=$i
	continue
    elif [ "$num" == "1" ]; then
        continue
    fi
    sshpass -p $i ssh ubuntu@$address -o StrictHostKeyChecking=no "sudo apt-get install git" 
    sshpass -p $i ssh ubuntu@$address -o StrictHostKeyChecking=no "git clone https://github.com/psy337337/aporrima.git; ./aporrima/hadoop/step1to3.sh $@"
done

# sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t
sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd; git clone https://github.com/psy337337/aporrima.git; ./aporrima/hadoop/connect.sh"



num=0
for i in $@
do
	num=$(($num+1))
	if [ "$(($num%2))" == "1" ]; then
		continue
	fi
	sshpass -p hadoop ssh hadoop@$i -o StrictHostKeyChecking=no -t "cd; git clone https://github.com/psy337337/aporrima.git; ./aporrima/hadoop/connect.sh"
done



echo "hadoop" | su - hadoop -c "cd; ./aporrima/hadoop/installHadoop.sh; source ~/.bashrc;"

./aporrima/hadoop/inputProfile.sh

sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd ~; pwd; source ~/.bashrc; ./aporrima/hadoop/setHadoop.sh"
