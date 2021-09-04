#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir data
mkdir data_website
read -p "Indicate your domain for silex: " domaineSilex
sed -i '/URL_SILEX/c\URL_SILEX='$domaineSilex .env

docker-compose -f docker-compose-with-traefik.yml up -d
