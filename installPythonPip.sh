#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

apt-get update
apt install python3-pip -y
pip install ovh
pip install bottle
pip install psutil
