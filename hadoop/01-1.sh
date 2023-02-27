#!/bin/bash

if [ $# -eq 0 ];then
    echo "Please Input ip address"
    exit 0
fi

./testAporrima/hadoop/step1to3.sh $@

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
    sshpass -p $i ssh ubuntu@$address -o StrictHostKeyChecking=no "./testAporrima/hadoop/step1to3.sh $@"
done
