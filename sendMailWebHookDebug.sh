#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

#work only in all data in a single line
Info=$(cat /var/log/cloud-init-output.log | tr -d '\r\n')

curl -X POST -H "Content-Type: text/plain" -d '{ "dest": "'"$1"'", "context":"info", "INFO":"'"$Info"'", "accessKey":"yferfVvV2XJ^NUzczr4YYQ*2iyXSGY7J" }' https://automate.omvpb.ovh/webhook/ef724898-b6d9-4387-9878-81ea4c74092e

