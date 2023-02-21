#!/bin/bash

cp $FLUME_HOME/conf/flume-conf.properties.template $FLUME_HOME/conf/flume-conf.properties
cat ./aporrima/flume/example1/flume-example1-conf.txt >> $FLUME_HOME/conf/flume-example1-conf.properties
mkdir -p /home/ubuntu/working/test


flume-ng agent \
-n agent1 \
-c $FLUME_HOME/conf \
-f $FLUME_HOME/conf/flume-example1-conf.properties \
-Dflume.root.logger=INFO, console
