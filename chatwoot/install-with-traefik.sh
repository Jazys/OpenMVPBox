#!/bin/bash

mkdir -p data-postgres
mkdir -p data-redis
mkdir -p data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for chatwoot: " domaine
else
      domaine=$1
      echo 'domaine for chatwoot is '$domaine
fi

sed -i '/URL_CHATWOOT/c\URL_CHATWOOT='$domaine .env

docker-compose -f docker-compose-with-traefik.yml --env-file .env build
docker-compose -f docker-compose-with-traefik.yml run --rm rails bundle exec rails db:chatwoot_prepare
docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
