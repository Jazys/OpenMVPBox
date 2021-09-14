#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

export PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)

curl -X POST -H "Content-Type: text/plain" -d '{ "dest": "'"$1"'", "context":"ip", "IP":"'"$PUBLIC_IPV4"'", "accessKey":"yferfVvV2XJ^NUzczr4YYQ*2iyXSGY7J" }' https://automate.omvpb.ovh/webhook/ef724898-b6d9-4387-9878-81ea4c74092e

sleep 60
