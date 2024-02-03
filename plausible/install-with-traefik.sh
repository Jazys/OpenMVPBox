#!/bin/bash
mkdir db_data
mkdir evt_data
mkdir geoip_data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for Plausible: " domaine
else
      domaine=$1
      echo 'domaine for PLAUSIBLE is 'domaine
fi

sed -i '/URL_PLAUSIBLE/c\URL_PLAUSIBLE='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d