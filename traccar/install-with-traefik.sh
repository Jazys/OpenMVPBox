#!/bin/bash

mkdir postgres-data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for Traccar: " domaine
else
      domaine=$1
      echo 'domaine for Traccar is 'domaine
fi
read -p "Indicate your domain for geoloc dashboard: " domaine
sed -i '/URL_TRACCAR/c\URL_TRACCAR='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d
