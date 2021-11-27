#!/bin/bash

mkdir -p data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for kuma: " domaine
else
      domaine=$1
      echo 'domaine for kuma is '$domaine
fi


sed -i '/URL_KUMA/c\URL_KUMA='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d 
