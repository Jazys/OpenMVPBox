#!/bin/bash

mkdir data
domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for Grist: " domaine
else
      domaine=$1
      echo 'domaine for Grist  is '$domaine
fi

sed -i '/URL_GRIST=/c\URL_GRIST='$domaine .env 


docker-compose -f docker-compose-with-traefik.yml up -d
