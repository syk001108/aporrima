SPARK_USER=spark
IS_SPARK_EXIST=$(grep spark /etc/passwd)

if [[ -n $IS_SPARK_EXIST ]]; then
    echo "DISCLAIMER: Spark user already exist"
    echo "This script will delete the existing Spark user and create a new Spark user"
    read -r -p "Proceed? [y/N] " RESPONSE
    if [[ ! $RESPONSE =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Aborting..."
        exit 1
    else
        sudo userdel -r $SPARK_USER
    fi
fi
    
sudo useradd $SPARK_USER
sudo passwd $SPARK_USER
sudo mkdir /home/$SPARK_USER
sudo chown $SPARK_USER:$SPARK_USER /home/$SPARK_USER
echo "$SPARK_USER user added"
