#!/bin/bash

mkdir postgres-data
mkdir data

domainepenpot=""
emailAdmin=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for penpot: " domainepenpot
else
      domainepenpot=$1
      echo 'domaine for penpot is 'domainepenpot
fi

sed -i '/PENPOT_PUBLIC_URI/c\PENPOT_PUBLIC_URI='$domainepenpot .env
sed -i '/URL_PENPOT/c\URL_PENPOT='$domainepenpot .env 

echo "Email login  for "$domainepenpot " is test@test.fr and password Azerty@1234" >> /tmp/toSendInfoByMail

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d

echo "wait 30 second for starting docker"
sleep 30

docker exec -ti penpot_penpot-backend_1 ./manage.sh create-profile -u test@test.fr -p Azerty@1234 -n test

