#!/bin/bash

mkdir -p postgres-data

domaineNoco=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for NocoDB: " $domaineNoco
else
      domaineNoco=$1
      echo 'domaine for NocoDB is '$domaineNoco
fi
sed -i '/URL_NOCODB/c\URL_NOCODB='$domaineNoco'' .env

docker-compose -f docker-compose-with-traefik.yml  up -d
