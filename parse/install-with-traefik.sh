#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p postgres-data

read -p "Indicate your domain for parse dashboard : " domaine
sed -i 's/URL_PARSE_DASH=/URL_PARSE_DASH='$domaine'/g' .env 

read -p "Indicate your domain for parse server  : " domaine
sed -i 's/URL_PARSE_SRV=/URL_PARSE_SRV='$domaine'/g' .env 

docker-compose -f docker-compose-with-traefik.yml up -d


