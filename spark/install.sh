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
        echo -n "hadoop" | su - hadoop -c "./aporrima/spark/setting-spark-on-yarn.sh"
        ;;
esac