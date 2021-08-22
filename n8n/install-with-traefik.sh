#!/bin/bash

mkdir -p ponstgres-data
chown postgres:postgres postgres-data/ -R
mkdir -p .n8n
chmod +x init-data.sh

read -p "Indicate your domain for n8n: " domaineN8n
sed -i '/N8N_WEBHOOK_TUNNEL_URL/c\N8N_WEBHOOK_TUNNEL_URL=https://'$domaineN8n'/' .env
