#!/bin/bash

# installing
wget http://mirror.navercorp.com/apache/flume/1.11.0/apache-flume-1.11.0-bin.tar.gz
tar -xvf apache-flume-1.11.0-bin.tar.gz

# mv & make link
mv apache-flume-1.11.0-bin /usr/local
ln -s /usr/local/apache-flume-1.11.0-bin/ /usr/local/flume

# setting environment
cat ./profile.txt >> /etc/profile
javah=$(readlink -f /usr/bin/java | sed 's:jre/bin/java::')
echo "export JAVA_HOME=${javah}" >> /etc/profile

source /etc/profile

# check flume install
flume-ng version
