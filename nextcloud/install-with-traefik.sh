#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p mariadb-data
mkdir -p data

read -p "Indicate your domain for nextcloud : " domaine
sed -i '/URL_NEXTCLOUD=/c\URL_NEXTCLOUD='$domaine .env 



docker-compose -f docker-compose-with-traefik.yml up -d
