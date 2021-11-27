#!/bin/bash

mkdir -p data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for focal: " domaine
else
      domaine=$1
      echo 'domaine for focal is '$domaine
fi
sed -i '/URL_FOCALBOARD/c\URL_FOCALBOARD='$domaine .env


docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
