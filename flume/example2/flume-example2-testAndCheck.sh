#!/bin/bash

echo "Test HDFS and flume" > /home/ubuntu/working/test/file-HDFS.txt
sleep 2s
ls -al /home/ubuntu/working/test
su - hadoop -c "hdfs dfs -ls /flume-test; hdfs dfs -text /flume-test/*;"
