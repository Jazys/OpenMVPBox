#!/bin/bash

mkdir -p ponstgres-data
chown postgres:postgres postgres-data/ -R
mkdir -p .n8n
chmod +x init-data.sh

sed -i '/N8N_WEBHOOK_TUNNEL_URL/c\N8N_WEBHOOK_TUNNEL_URL=http://'$(hostname  -I | cut -f1 -d' ')':5678/' .env
