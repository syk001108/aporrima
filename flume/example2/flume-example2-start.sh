#!/bin/bash

cp $FLUME_HOME/conf/flume-conf.properties $FLUME_HOME/conf/spool-to-hdfs.properties
cat ./aporrima/flume/example2/flume-example2-conf.txt >> $FLUME_HOME/conf/spool-to-hdfs.properties

cp $HADOOP_HOME/share/hadoop/common/lib/guava-27.0-jre.jar $FLUME_HOME/lib
mv $FLUME_HOME/lib/guava-11.0.2.jar $FLUME_HOME/lib/guava-11.0.2.jar.bak

su - hadoop -c "hdfs dfs -ls /;hdfs dfs -mkdir -p /flume-test; hdfs dfs -chmod 777 /flume-test; hdfs dfs -ls /;"

flume-ng agent -n agent1 -c $FLUME_HOME/conf -f $FLUME_HOME/conf/spool-to-hdfs.properties -Dflume.root.logger=INFO, console
