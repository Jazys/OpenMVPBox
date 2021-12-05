#!/bin/bash

mkdir -p data
mkdir -p data-mysql

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for Matomo: " domaine
else
      domaine=$1
      echo 'domaine for Matomo is '$domaine
fi

sed -i '/URL_MATOMO/c\URL_MATOMO='$domaine .env

docker-compose -f docker-compose-with-traefik.yml --env-file .env up 