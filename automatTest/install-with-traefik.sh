#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p dataClientSftp
mkdir -p configSftp
cp configSftp.json configSftp/sftp.json
mkdir -p TestReport

read -p "Indicate your domain for e2e test: " domaine
sed -i 's/URL_REPORT=/URL_REPORT='$domaine'/g' .env 

read -p "Indicate your domain for sftp client : " domaine
sed -i 's/URL_CLI_SFTP=/URL_CLI_SFTP='$domaine'/g' .env 

docker-compose -f docker-compose-with-traefik.yml up -d


