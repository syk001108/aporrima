#!/bin/bash

num=1
cnt=0
for i in $@
do
    num=$(($num+1))
    if [ "$num" == "2" ]; then
        sudo sed -i "$num i$i hdn" /etc/hosts
	continue
    elif [ "$(($num%2))" == "0" ]; then
        continue
    fi
    cnt=$(($cnt+1))
    sudo sed -i "$num i$i hdw$cnt" /etc/hosts
done
