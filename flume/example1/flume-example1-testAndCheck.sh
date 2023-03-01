#!/bin/bash

echo "Example1 flume" > /home/ubuntu/working/test/file01.txt
sleep 2s
ls -al /home/ubuntu/working/test/
cat flume.log | grep COMPLETED
