#!/bin/bash

JAVA_PATH=$(update-alternatives --list java)

if [[ -z $JAVA_PATH ]]; then
    sudo apt-get install openjdk-11-jdk-headless -y
    JAVA_PATH=$(update-alternatives --list java)
fi

cat <<EOF | sudo tee /etc/profile.d/java.sh
export JAVA_HOME=${JAVA_PATH%"/bin/java"}
export PATH=\$JAVA_HOME/bin:\$PATH
EOF

source /etc/profile.d/java.sh