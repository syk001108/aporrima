#!/bin/bash

cat ./aporrima/hadoop/profile.txt | sudo tee -a /etc/profile
source /etc/profile
