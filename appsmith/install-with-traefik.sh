#!/bin/bash

mkdir -p ./data/mongo/db

domaineAppsmith=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for Appsmith: " domaineAppsmith
else
      domaineAppsmith=$1
      echo 'domaine for appsmith is 'domaineAppsmith
fi
sed -i '/URL_APPSMITH/c\URL_APPSMITH='$domaineAppsmith'' docker.env

docker-compose -f docker-compose-with-traefik.yml --env-file docker.env up -d
