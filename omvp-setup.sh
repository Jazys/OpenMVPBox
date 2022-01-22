#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

cd /root
git clone https://github.com/Jazys/OpenMVPBox.git
cd OpenMVPBox
chmod +x makeScriptExec.sh
./automaticInstall.sh $1
