#!/bin/bash

mkdir -p data

chown 472:0 data/ -R

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for grafana: " domaine
else
      domaine=$1
      echo 'domaine for grafana is '$domaine
fi

sed -i '/URL_GRAFANA/c\URL_GRAFANA='$domaine .env

docker-compose -f docker-compose-with-traefik.yml --env-file .env up 