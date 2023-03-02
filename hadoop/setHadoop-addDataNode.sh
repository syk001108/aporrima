#!/bin/bash

# setting workers
cat /dev/null > ./hadoop/etc/hadoop/workers
for i in $(sed -n '/hd/p' /etc/hosts)
do
	if [[ "${i}" == *"hdw"* ]];then
		echo $i >> ./hadoop/etc/hadoop/workers
	fi
done


linecnt=$(sed -n '/hd/p' /etc/hosts | wc -l)
for ((i=1; i<$linecnt; i++))
do
	scp -r /home/hadoop/* hadoop@hdw$i:/home/hadoop/
done
