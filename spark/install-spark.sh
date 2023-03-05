#!/bin/bash

SPARK_VERSION=spark-3.3.2
SPARK_TGZ=spark-3.3.2-bin-hadoop3.tgz
SPARK_PATH=$(pwd)

if [[ -d $SPARK_PATH/${SPARK_TGZ%".tgz"} ]]; then
    echo "Spark already installed"
else
    wget https://dlcdn.apache.org/spark/$SPARK_VERSION/$SPARK_TGZ
    tar zxvf $SPARK_TGZ
    sudo rm ./$SPARK_TGZ
    sudo ln -s $SPARK_PATH/${SPARK_TGZ%".tgz"}/ $SPARK_PATH/spark

    cat <<EOF | sudo tee -a ~/.bashrc
export SPARK_HOME=$SPARK_PATH/${SPARK_TGZ%".tgz"}
export PATH=\$SPARK_HOME/bin:\$PATH
export PYSPARK_PYTHON=/usr/bin/python3
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook --ip=0.0.0.0'
EOF

    source ~/.bashrc
fi

# sudo chmod -R 777 /home/spark