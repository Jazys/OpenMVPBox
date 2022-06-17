#!/bin/bash

mkdir -p postgres-data

domaineNoco=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for NocoDB: " $domaineNoco
else
      domaineNoco=$1
      echo 'domaine for NocoDB is '$domaineNoco
fi
sed -i '/URL_NOCODB/c\URL_NOCODB='$domaineNoco'' .env

if [ -z "$2" ]
then
      echo "default user id 1"
else
      sed -i '/USER_ID/c\USER_ID='$2 .env
fi

echo 'For NocoDB use this url https://'$domaineNoco' create a superadmin user for the first connexion ' >> /tmp/toSendInfoByMail

docker-compose -f docker-compose-with-traefik.yml  up -d
