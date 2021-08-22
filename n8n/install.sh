#!/bin/bash

mkdir -p postgres-data
chmod +x /home/ubuntu/n8n/init-data.sh
echo  "N8N_WEBHOOK_TUNNEL_URL=http://"$(hostname  -I | cut -f1 -d' ')":5678/" >> .env
