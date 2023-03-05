#!/bin/bash

echo "Please select a number that corresponds to the desired installation mode"
read -r -p "(1 : Local Standalone / 2 : Standalone Cluster / 3 : Spark on YARN ) : " response
./aporrima/spark/setting-prev.sh

case $response in
    1)
        echo "Set up local standalone mode"
        echo "Start install Spark"
        echo -n "spark" | su - spark -c "./aporrima/spark/install-spark.sh"
        echo -n "spark" | su - spark -c "./aporrima/spark/setting-standalone.sh"
        ;;
    2)
        echo "Set up standalone cluster mode"
        ./aporrima/spark/add-host.sh
        echo -n "spark" | su - spark -c "./aporrima/spark/install-spark.sh"
        echo -n "spark" | su - spark -c "./aporrima/spark/setting-standalone-cluster.sh"
        echo -n "spark" | su - spark -c "./spark/sbin/start-all.sh"
        ;;
    3)
        echo "Set up Spark on YARN mode"
        echo "Start install Spark"
        echo -n "hadoop" | su - hadoop -c "./aporrima/spark/install-spark.sh"
        cat <<EOF | sudo tee /etc/profile.d/hadoop.sh
export HADOOP_HOME=/home/hadoop/hadoop-3.3.4
export HADOOP_INSTALL=\$HADOOP_HOME 
export HADOOP_MAPRED_HOME=\$HADOOP_HOME

export HADOOP_COMMON_HOME=\$HADOOP_HOME

export HADOOP_HDFS_HOME=\$HADOOP_HOME

export YARN_HOME=\$HADOOP_HOME

export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native 
export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin

export HADOOP_OPTS="-Djava.library.path=\$HADOOP_HOME/lib/native"
EOF
        source /etc/profile.d/hadoop.sh
        echo -n "hadoop" | su - hadoop -c "./aporrima/spark/setting-spark-on-yarn.sh"
        ;;
esac