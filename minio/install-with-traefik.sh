#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir data
read -p "Indicate your domain for minio: " domaine
sed -i '/URL_MINIO/c\URL_MINIO='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d
