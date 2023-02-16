#!/bin/bash
cat /dev/null > $HADOOP_HOME/etc/hadoop/workers
for i in $(sed -n '/hd/p' /etc/hosts)
do
	if [[ "${i}" == *"hdw"* ]];then
		echo $i > $HADOOP_HOME/etc/hadoop/workers
	fi
done




javah=$(readlink -f /usr/bin/java | sed 's:jre/bin/java::')
sed -i "/export JAVA_HOME/ c\export JAVA_HOME=${javah}" $HADOOP_HOME/etc/hadoop/hadoop-env.sh



lists=("core-site" "hdfs-site" "mapred-site" "yarn-site")

for i in "${lists[@]}"
do
	sed -i "/configuration>/d" $HADOOP_HOME/etc/hadoop/${i}.xml
	cat ${i}.txt >> $HADOOP_HOME/etc/hadoop/${i}.xml	
done
sed -i "s/127.0.0.1/$(hostname -I | sed -e 's/  *$//')/g" $HADOOP_HOME/etc/hadoop/core-site.xml
sed -i "s/0.0.0.0/$(hostname -I | sed -e 's/  *$//')/g" $HADOOP_HOME/etc/hadoop/yarn-site.xml



linecnt=$(sed -n '/hd/p' /etc/hosts | wc -l)
for ((i=1; i<$linecnt; i++))
do
	scp -r /home/hadoop/* hadoop@hdw$i:/home/hadoop/
done



hdfs namenode -format

/home/hadoop/hadoop-3.3.4/sbin/start-dfs.sh
/home/hadoop/hadoop-3.3.4/sbin/start-yarn.sh
