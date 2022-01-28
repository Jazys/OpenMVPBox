#!/bin/bash

mkdir -p postgres-data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for parse dashboard: " domaine
else
      domaine=$1
      echo 'domaine for parse dashboard is '$domaine
fi

sed -i '/URL_PARSE_DASH=/c\URL_PARSE_DASH='$domaine .env 

sed -i '/URL_PARSE_SRV=/c\URL_PARSE_SRV=back-'$domaine .env 

sed -i 's/xxxx/'$domaine'/g' config.json

docker-compose -f docker-compose-with-traefik.yml up -d


