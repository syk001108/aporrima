#!/bin/bash


cd /home/hadoop
wget https://downloads.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz
tar xzf hadoop-3.3.4.tar.gz


cat bashrc.txt >> /home/hadoop/.bashrc
source ~/.bashrc
