#!/bin/bash

# setting workers
cat /dev/null > ./hadoop/etc/hadoop/workers
for i in $(sed -n '/hd/p' /etc/hosts)
do
        if [[ "${i}" == *"hdw"* ]];then
                echo $i >> ./hadoop/etc/hadoop/workers
        fi
done




javah=$(readlink -f /usr/bin/java | sed 's:bin/java::')
sed -i "/export JAVA_HOME/ c\export JAVA_HOME=${javah}" ./hadoop/etc/hadoop/hadoop-env.sh



lists=("core-site" "hdfs-site" "mapred-site" "yarn-site")

for i in "${lists[@]}"
do
        sed -i "/configuration>/d" ./hadoop/etc/hadoop/${i}.xml
        cat ./aporrima/hadoop/${i}.txt >> ./hadoop/etc/hadoop/${i}.xml
done
sed -i "s/127.0.0.1/$(hostname -I | sed -e 's/  *$//')/g" ./hadoop/etc/hadoop/core-site.xml
sed -i "s/0.0.0.0/$(hostname -I | sed -e 's/  *$//')/g" ./hadoop/etc/hadoop/yarn-site.xml



linecnt=$(sed -n '/hd/p' /etc/hosts | wc -l)
for ((i=1; i<$linecnt; i++))
do
        scp -r -o StrictHostKeyChecking=no /home/hadoop/* hadoop@hdw$i:/home/hadoop/
done

