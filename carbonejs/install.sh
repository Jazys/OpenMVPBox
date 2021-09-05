#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p dataClientSftp
mkdir -p configSftp
cp configSftp.json configSftp/sftp.json

docker-compose up -d
