#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir postgres-data
mkdir data

read -p "Indicate your domain for penpot: " domainepenpot
sed -i 's/PENPOT_PUBLIC_URI/PENPOT_PUBLIC_URI='$domainepenpot'/g' config.env
sed -i 's/URL_PENPOT/URL_PENPOT='$domainepenpot'/g' config.env 

docker-compose -f docker-compose-with-traefik.yml --env-file config.env up -data

echo "wait 30 second for starting docker"
sleep 30

docker exec -ti penpot_penpot-backend_1 ./manage.sh create-profile