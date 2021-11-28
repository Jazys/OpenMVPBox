#!/bin/bash

mkdir -p postgres-data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for keycloack: " domaine
else
      domaine=$1
      echo 'domaine for keycloak is '$domaine
fi


sed -i '/URL_KEYCLOAK/c\URL_KEYCLOAK='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d 
