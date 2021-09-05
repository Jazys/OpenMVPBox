#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p dataClientSftp
mkdir -p configSftp
cp configSftp.json configSftp/sftp.json

read -p "Indicate your domain for serving file: " domaine
sed -i '/URL_CARBONE=/c\URL_CARBONE='$domaine .env 

read -p "Indicate your domain for sftp client : " domaine
sed -i '/URL_CLI_SFTP=/c\URL_CLI_SFTP='$domaine .env 

docker-compose -f docker-compose-with-traefik.yml up -d
