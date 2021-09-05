#!/bin/bash

mkdir -p postgres-data
mkdir -p .n8n
chmod +x init-data.sh

domaineN8n=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for n8n: " domaineN8n
else
      domaineN8n=$1
      echo 'domaine for n8n is '$domaineN8n
fi
sed -i '/N8N_WEBHOOK_TUNNEL_URL/c\N8N_WEBHOOK_TUNNEL_URL=https://'$domaineN8n'/' .env
sed -i '/URL_N8N/c\URL_N8N='$domaineN8n .env

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
