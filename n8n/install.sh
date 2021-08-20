#!/bin/bash

mkdir -p postgres-data

echo  "N8N_WEBHOOK_TUNNEL_URL=http://"$(hostname  -I | cut -f1 -d' ')":5678/" >> .env
