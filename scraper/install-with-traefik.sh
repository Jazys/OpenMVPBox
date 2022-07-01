#!/bin/bash

mkdir -p data
domaine=""
url=""


if [ -z "$1" ]
then
      read -p "Indicate your url: " domaine
else
      domaine=$1
      echo 'domaine for scraper is '$domaine
fi

if [ -z "$2" ]
then
      echo "default user id 1"
else
      sed -i '/USER_ID/c\USER_ID='$2 .env
fi

sed -i '/URL_SCRAPER=/c\URL_SCRAPER='$domaine .env 


docker-compose -f docker-compose-with-traefik.yml up --build -d



