#!/bin/bash

mkdir -p postgres-data
mkdir -p app

read -p "Indicate your domain for strapi: " domaine
sed -i '/URL_STRAPI/c\URL_STRAPI='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d 
