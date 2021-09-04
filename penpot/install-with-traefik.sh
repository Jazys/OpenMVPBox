#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir postgres-data
mkdir data

read -p "Indicate your domain for penpot: " domainepenpot
sed -i '/PENPOT_PUBLIC_URI/c\PENPOT_PUBLIC_URI='$domainepenpot config.env
sed -i '/URL_PENPOT/c\URL_PENPOT='$domainepenpot config.env 

docker-compose -f docker-compose-with-traefik.yml --env-file config.env up -d

echo "wait 30 second for starting docker"
sleep 30

docker exec -ti penpot_penpot-backend_1 ./manage.sh create-profile -u test@test.fr -p Azerty@1234 -n test

