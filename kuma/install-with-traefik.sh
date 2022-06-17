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

if [ -z "$2" ]
then
      echo "default user id 1"
else
      sed -i '/USER_ID/c\USER_ID='$2 .env
fi

docker-compose -f docker-compose-with-traefik.yml up -d 
