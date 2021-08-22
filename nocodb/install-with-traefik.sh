#!/bin/bash

mkdir -p postgres-data

read -p "Indicate your domain for NocoDB: " domaineNoco
sed -i '/URL_NOCODB/c\URL_NOCODB='$domaineNoco'' .env

docker-compose -f docker-compose-with-traefik.yml  up -d
