#!/bin/bash

mkdir -p postgres-data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for metabase: " domaine
else
      domaine=$1
      echo 'domaine for n8n is '$domaine
fi


sed -i '/URL_META/c\URL_META='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d 
