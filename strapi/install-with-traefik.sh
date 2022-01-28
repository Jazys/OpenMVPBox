#!/bin/bash

mkdir -p postgres-data
mkdir -p app

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for strapi: " domaine
else
      domaine=$1
      echo 'domaine for strapi is '$domaine
fi

sed -i '/URL_STRAPI/c\URL_STRAPI='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d 
