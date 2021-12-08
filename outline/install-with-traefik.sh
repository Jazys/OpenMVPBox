#!/bin/bash

mkdir -p data-postgres
mkdir -p data-redis

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for outline: " domaine
else
      domaine=$1
      echo 'domaine for outline is '$domaine
fi

sed -i '/URL_OUTLINE/c\URL_OUTLINE='$domaine .env

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
