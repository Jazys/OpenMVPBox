#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p postgres-data

read -p "Indicate your domain for parse dashboard : " domaine
sed -i '/URL_PARSE_DASH=/c\URL_PARSE_DASH='$domaine .env 

read -p "Indicate your domain for parse server  : " domaine
sed -i '/URL_PARSE_SRV=/c\URL_PARSE_SRV='$domaine .env 

sed -i 's/xxxx/'$domaine'/g' config.json

docker-compose -f docker-compose-with-traefik.yml up -d


