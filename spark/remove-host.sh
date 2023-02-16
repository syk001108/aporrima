#!/bin/sh

ETC_HOSTS=/etc/hosts
HOSTNAME=$1
HOSTS_LINE="$IP\t$HOSTNAME"

if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
then
    echo "$HOSTNAME Found in your $ETC_HOSTS, Removing now...";
    sudo sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS
else
    echo "$HOSTNAME was not found in your $ETC_HOSTS";
fi

