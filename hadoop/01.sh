#!/bin/bash

if [ $# -eq 0 ];then
    echo "Please Input ip address"
    exit 0
fi

./testAporrima/hadoop/step1to3.sh $1 $2

#first time can't used sshpass
sshpass -p $3 ssh ubuntu@$2 -o StrictHostKeyChecking=no "sudo apt-get install git" 
sshpass -p $3 ssh ubuntu@$2 -o StrictHostKeyChecking=no "git clone https://github.com/psy337337/testAporrima.git; ./testAporrima/hadoop/step1to3.sh $1 $2"

