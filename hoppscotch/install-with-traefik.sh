#!/bin/bash

mkdir -p data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for hoppscotch: " domaine
else
      domaine=$1
      echo 'domaine for hoppscotch is '$domaine
fi

sed -i '/BASE_URL/c\BASE_URL=https:\/\/'$domaine .env

sed -i '/URL_HOPP/c\URL_HOPP='$domaine .env

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
