# Hadoop

# Environment Setup

## Step 1 - Environmental Preparation  
- ubuntu 22.04
- apt update
- OpenJDK 8
- OpenSSH
    - SSH Server Configuration Settings
        - `/etc/ssh/sshd_config`
        - To access without writing a password
- net-tools   

### ❗C**aution**❗

1. Proceed from **an account where `sudo` command is available**
2. Run on both **NameNode and DataNode**  

### 🔸Script  
[install.sh](https://github.com/psy337337/aporrima/blob/main/hadoop/install.sh)    

### ▶Execute

🔹Input

```
./install.sh
```

## Step 2 - **Register domain to host**

For smooth connection of NameNode and DataNode.

- Write an ip address in a file `/etc/hosts`
    - NameNode
        - `xxx.xxx.xxx.xxx hdn`
    - DataNode
        - `xxx.xxx.xxx.xxx hdw1`
        - `xxx.xxx.xxx.xxx hdw2`
        - …

### ❗C**aution**❗

1. Proceed from **an account where `sudo` command is available**
2. Run on both **NameNode and DataNode**

### 🔸Script  
[hostset.sh](https://github.com/psy337337/aporrima/blob/main/hadoop/hostset.sh)


### ▶Execute

🔹Input

```
./hostset.sh (NameNode's ip address) (DataNode's ip address) (DataNode's ip address)...
```

🔹Example

```
./hostset.sh 10.0.20.157 10.0.20.181 10.0.20.182 10.0.20.183 
```

## Step 3 - Create a Hadoop account

Create Hadoop-only user accounts to distinguish Hadoop processes from other services running on the same computer

- User name
    - `hadoop`
- User passwd
    - `hadoop`
- User home directory
    - `/home/hadoop`

### ❗C**aution**❗

1. Proceed from **an account where `sudo` command is available**
2. Run on both **NameNode and DataNode**
3. **Must not have** a Hadoop account
    - If you have an account, `sudo userdel -rf hadoop`

### 🔸Script  
[makeUser.sh](https://github.com/psy337337/aporrima/blob/main/hadoop/makeUser.sh)  


### ▶Execute

🔹Input

```
./makeUser.sh
cd 
```

- Can enter `/home/hadoop` folder to `cd` command

## Step 4 - Nodes set up connection without password

Access without SSH password with public key authentication

### ❗C**aution**❗

1. Run on both **NameNode and DataNode**
2. When the password input window appears,
    1. Input `hadoop` 
3. Recommendation for confirmation of connection afterwards (All  ip address / excluding personal ip address)
    
    ex. `ssh hadoop@hdn`
    

### 🔸Script  
[connect.sh](https://github.com/psy337337/aporrima/blob/main/hadoop/connect.sh)


### ▶Execute

🔹Input

```
./connect.sh
```

🔹Example (NameNode)

```
./coonect.sh
ssh hadoop@hdw1
ssh hadoop@hdw2
ssh hadoop@hdw3
...
```

- Check password-free access

## Step 5 - Install Hadoop

- hadoop 3.3.4
- Setting environment variables
    - `/home/hadoop/.bashrc`
    - [bashrc.txt]([https://github.com/psy337337/aporrima/blob/main/hadoop/bashrc.txt](https://github.com/psy337337/aporrima/blob/main/hadoop/bashrc.txt))

### ❗C**aution**❗

1. Run **only on NameNode**
2. Input `echo $HADOOP_HOME` after execution
    - If there is no output value
        - Input `. ~/.bashrc` or `source ~/.bashrc`
        

### 🔸Script  
[installHadoop.sh](https://github.com/psy337337/aporrima/blob/main/hadoop/installHadoop.sh)


### ▶Execute

🔹Input

```
./installHadoop.sh
```

🔹Example

```
./installHadoop.sh
. ~/.bashrc
```

- Check environment variables are applied

## Step 6 - Hadoop Setting & Start

Setting to run Hadoop and running Hadoop

- Enter DataNode in `$HADOOP_HOME/etc/hadoop/workers`
    - `hdw1`
    - `hdw2`
    - …
- Setting `JAVA_HOME`
    - `$HADOOP_HOME/etc/hadoop/hadoop-env.sh`
- `core-site.xml`
    - [core-site.txt](https://github.com/psy337337/aporrima/blob/main/hadoop/core-site.txt)
    - Common environment settings for hdfs and map reduce
    - Setting the ip address for file system metadata-related operations
        - Setting address to NameNode ip address
- `hdfs-site.xml`
    - [hdfs-site.txt](https://github.com/psy337337/aporrima/blob/main/hadoop/hdfs-site.txt)
    - Configuration settings for use by hdfs
- `mapred-site.xml`
    - [mapred-site.txt](https://github.com/psy337337/aporrima/blob/main/hadoop/mapred-site.txt)
    - Configuration settings for use by map reduce
- `yarn-site.xml`
    - [yarn-site.txt](https://github.com/psy337337/aporrima/blob/main/hadoop/yarn-site.txt)
    - Configuration settings for use by yarn
    - Set ip address in `yarn.resourcemanager.address`
        - Setting address to NameNode ip address
    - Set ip address in `yarn.router.webapp.address`
        - Setting address to NameNode ip address

### ❗C**aution**❗

1. Run **only on NameNode**
2. If you want to shut down/restart Hadoop after running
    - Hadoop shut down
        - `$HADOOP_HOME/sbin/stop-all.sh`
    - Hadoop restart
        - `$HADOOP_HOME/sbin/start-all.sh`

### 🔸Script  
[setHadoop.sh](https://github.com/psy337337/aporrima/blob/main/hadoop/setHadoop.sh)


### ▶Execute

🔹Input

```
./setHadoop.sh
```

🔹Example

```
./setHadoop.sh
jps
```

- `jps` command allows you to check the running process
    - NameNode
        - `SecondaryNameNode`
        - `WebAppProxyServer`
        - `NameNode`
        - `ResourceManager`
    - DataNode
        - `DataNode`
        - `NodeManager`
