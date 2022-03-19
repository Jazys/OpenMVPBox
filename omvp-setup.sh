#!/bin/bash

cd /root
git clone https://github.com/Jazys/OpenMVPBox.git
cd OpenMVPBox
chmod +x makeScriptExec.sh
./automaticInstall.sh $1
cat /tmp/toSendInfoByMail
