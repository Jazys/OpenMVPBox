#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

apt install python3-pip -y
pip install ovh

