#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p dataClientSftp
mkdir -p configSftp
cp configSftp.json configSftp/sftp.json
mkdir -p TestReport

read -p "Indicate your domain for e2e test: " domaine
sed -i '/URL_REPORT=/c\URL_REPORT='$domaine .env 

read -p "Indicate your domain for sftp client : " domaine
sed -i '/URL_CLI_SFTP=/c\URL_CLI_SFTP='$domaine .env 

docker-compose -f docker-compose-with-traefik.yml up -d


