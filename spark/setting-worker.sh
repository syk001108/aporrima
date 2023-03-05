#!/bin/bash

./aporrima/spark/setting-pre.sh

SPARK_PATH=spark-3.3.2-bin-hadoop3
echo -n "spark" | su - spark -c 'cat <<EOF | sudo tee -a ~/.bashrc
export PATH=\$SPARK_HOME/bin:\$PATH
export PYSPARK=/usr/bin/python3
export PYSPARK_DRIVER_PYTHON=jupyter
EOF'
echo -n "spark" | su - spark -c "cat <<EOF | sudo tee -a ~/.bashrc
export SPARK_HOME=/home/spark/$SPARK_PATH
export PYSPARK_DRIVER_PYTHON_OPTS='notebook --ip=0.0.0.0'
EOF"
echo -n "spark" | su - spark -c "source ~/.bashrc"