#!/bin/bash

mkdir -p postgres-data
#chown postgres:postgres postgres-data/ -R
#find better solution !!!
#chmod 777 postgres-data/ -R

mkdir -p .n8n
chmod +x init-data.sh

read -p "Indicate your domain for n8n: " domaineN8n
sed -i '/N8N_WEBHOOK_TUNNEL_URL/c\N8N_WEBHOOK_TUNNEL_URL=https://'$domaineN8n'/' .env

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
