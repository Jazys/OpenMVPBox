#!/bin/bash

mkdir data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for Minio: " domaine
else
      domaine=$1
      echo 'domaine for Minio is 'domaine
fi

sed -i '/URL_MINIO/c\URL_MINIO='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d
