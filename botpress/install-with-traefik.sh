#!/bin/bash

mkdir -p data
mkdir -p data-postgres
mkdir -p data-lang

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for botpress: " domaine
else
      domaine=$1
      echo 'domaine for botpress is '$domaine
fi

sed -i '/URL_BOTPRESS/c\URL_BOTPRESS='$domaine .env

docker-compose -f docker-compose-with-traefik.yml --env-file .env up 