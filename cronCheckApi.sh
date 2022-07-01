#!/bin/bash

res=$(wget --spider -S "http://192.168.X.X:9080" 2>&1 | grep "HTTP/")

if [[ $res == *"404 Not Found"* ]]; then
  echo "service alive"
else
  systemctl restart omvpb-back.service
  echo "restart"
fi

#to put in crontab -e
#* * * * * /root/OpenMVPBox/cronCheckApi.sh

