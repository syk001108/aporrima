#!/bin/bash

# sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t
sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd; ./testAporrima/hadoop/connect.sh"



num=0
for i in $@
do
	num=$(($num+1))
	if [ "$(($num%2))" == "1" ]; then
		continue
	fi
	sshpass -p hadoop ssh hadoop@$i -o StrictHostKeyChecking=no -t "cd; ./testAporrima/hadoop/connect.sh"
done



echo "hadoop" | su - hadoop -c "cd; ./testAporrima/hadoop/installHadoop.sh; source ~/.bashrc;"

sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd ~; pwd; source ~/.bashrc; ./testAporrima/hadoop/setHadoop.sh"
