#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir postgres-data
mkdir upload
read -p "Indicate your domain for codi dashboard: " domaine
sed -i '/URL_CODI/c\URL_CODI='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d

sleep 60

docker exec -it codimd_codimd_1 /bin/bash -c 'cd bin && NODE_ENV=production ./manage_users --pass azerty --add admin@admin.fr'
