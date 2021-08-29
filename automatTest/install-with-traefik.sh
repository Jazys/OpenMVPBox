#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p dataClientSftp
mkdir -p configSftp
read -p "Indicate your domain for e2e test: " domaine

#sed -i 's/PENPOT_PUBLIC_URI/PENPOT_PUBLIC_URI='$domaine'/g' config.env
#sed -i 's/URL_PENPOT/URL_PENPOT='$domainepenpot'/g' config.env 

#docker-compose -f docker-compose-with-traefik.yml --env-file config.env up -data

#echo "wait 30 second for starting docker"
#sleep 30

#docker exec -ti penpot_penpot-backend_1 ./manage.sh create-profile
