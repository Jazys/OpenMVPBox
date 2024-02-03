#!/bin/bash
mkdir _data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for ChangeDetection: " domaine
else
      domaine=$1
      echo 'domaine for ChangeDetection is 'domaine
fi

sed -i '/URL_CHANGEDETECTION/c\URL_CHANGEDETECTION='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d
