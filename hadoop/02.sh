#!/bin/bash

# sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t
sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd; ./testAporrima/hadoop/connect.sh"


ssh hadoop@$2 -o StrictHostKeyChecking=no -t "cd; ./testAporrima/hadoop/connect.sh"



echo "hadoop" | su - hadoop -c "cd; ./testAporrima/hadoop/installHadoop.sh; source ~/.bashrc;"

sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd ~; pwd; source ~/.bashrc; ./testAporrima/hadoop/setHadoop.sh"
