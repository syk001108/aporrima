# Spark

# Environment Setup

## **Step 1** - Environmental Preparation
- ubuntu 22.04
- apt update
- OpenJDK 8
- Python3 & pip3
- jupyternotebook
- matplotlib
- OpenSSH
    - SSH Server Configuration Settings
        - `/etc/ssh/sshd_config`
        - To access without writing a password
- net-tools   

### ❗**Caution**❗

1. Proceed from **an account where `sudo` command is available**
2. Run on both **Master Node(Namenode) and Worker Node(Datanode)**  

### 🔸Script  
[install-java.sh](https://github.com/boanlab/aporrima/blob/main/spark/install-java.sh)

[install-python.sh](https://github.com/boanlab/aporrima/blob/main/spark/install-python.sh) 


### ▶Execute

🔹Input

```
git clone https://github.com/boanlab/aporrima.git
./aporrima/spark/install-java.sh
./aporrima/spark/install-python.sh
source ~/.bashrc
```

## **Step 2** - Create a Spark account

Create Spark-only user accounts to distinguish Spark processes from other services running on the same computer

- User name
    - `spark`
- User passwd
    - `spark`
- User home directory
    - `/home/spark`

### ❗**Caution**❗

1. Proceed from **an account where `sudo` command is available**
2. Run on both **Master Node(Namenode) and Worker Node(Datanode)**
3. If the Spark user exist, this script **delete the user and create a new one**

### 🔸Script  
[add-host.sh](https://github.com/boanlab/aporrima/blob/main/spark/add-spark-user.sh)


### ▶Execute

🔹Input

```
./aporrima/spark/install-python.sh
exit
```

## **Step 3** - Install Spark

- Spark 3.3.1

### ❗**Caution**❗

1. Proceed from **an account where `sudo` command is available**
2. Run on both **Master Node(Namenode) and Worker Node(Datanode)**
3. If you want to delploy **local standalone or Spark on YARN mode**
    - Install only on the Master Node 
4. Input `echo $HADOOP_HOME` after execution
    - If there is no output value
        - Input `. ~/.bashrc` or `source ~/.bashrc`

### 🔸Script  
[install-spark.sh](https://github.com/boanlab/aporrima/blob/main/spark/install-spark.sh)  


### ▶Execute

🔹Input

```
./aporrima/spark/install-spark.sh
source ~/.bashrc
```

## **Step 4.1** - Set up to local standalone mode

Standalone mode refers to a mode in which a cluster is configured with Spark alone without using another cluster manager. This script will sets the standalone mode to a single node.

### ❗**Caution**❗

1. Proceed from **an account where `sudo` command is available**
2. Run **only on Master Node**
    - A single node has a master and a worker 

### 🔸Script  
[setting-standalone.sh](https://github.com/boanlab/aporrima/blob/main/spark/setting-standalone.sh)  


### ▶Execute

🔹Input

```
./aporrima/spark/install-python.sh
```

🔹Example (NameNode)

```
su - spark
jps
{pid} Master
{pid} Worker
{pid} jps
```
- Check that the master&worker process work on JVM 

## **Step 4.2** - Set up to Spark on YARN mode

Spark on YARN mode runs on Hadoop cluster **where YARN is the cluster manager**

### ❗C**aution**❗

1. Run **only on Master Node(Namenode)**
    - Namenode has ResourceManager process
    
### 🔸Script  
[setting-spark-on-yarn.sh](https://github.com/boanlab/aporrima/blob/main/spark/setting-spark-on-yarn.sh)

### ▶Execute

🔹Input

```
./aporrima/spark/setting-spark-on-yarn.sh
```

🔹Example (NameNode)

```
spark-submit --master yarn --deploy-mode client $SPARK_HOME/examples/src/main/python/pi.py
```
- Use `spark-submit` to check