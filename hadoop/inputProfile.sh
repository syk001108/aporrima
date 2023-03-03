#!/bin/bash

cat ./profile.txt | sudo tee -a /etc/profile
. /etc/profile
