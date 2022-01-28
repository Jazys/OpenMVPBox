#!/bin/bash
mkdir mysql

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for Ghost: " domaine
else
      domaine=$1
      echo 'domaine for Ghost is 'domaine
fi

sed -i '/URL_GHOST/c\URL_GHOST='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d
