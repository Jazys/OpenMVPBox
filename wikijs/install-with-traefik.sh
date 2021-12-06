#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p postgres-data

if [ -z "$1" ]
then
      read -p "Indicate your domain for WikiJS: " domaine
else
      domaine=$1
      echo 'domaine for WikiJS is '$domaine
fi

sed -i '/URL_WIKI=/c\URL_WIKI='$domaine .env 



docker-compose -f docker-compose-with-traefik.yml up -d
