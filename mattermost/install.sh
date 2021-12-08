#!/bin/bash

mkdir data-config
mkdir data-matter
mkdir data-plugins
mkdir data-postgres

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for Mattermost: " domaine
else
      domaine=$1
      echo 'domaine for Mattermost is '$domaine
fi

sed -i '/URL_MATTERMOST/c\URL_MATTERMOST='$domaine .env

docker-compose  --env-file .env up -d
