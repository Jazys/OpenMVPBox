#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p mariadb-data
mkdir -p data

if [ -z "$1" ]
then
      read -p "Indicate your domain for nextcloud: " domaine
else
      domaine=$1
      echo 'domaine for nextcloud is '$domaine
fi

sed -i '/URL_NEXTCLOUD=/c\URL_NEXTCLOUD='$domaine .env 



docker-compose -f docker-compose-with-traefik.yml up -d
