#!/bin/bash

mkdir -p data-minio
mkdir -p data-redis
mkdir -p data-couchdb

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for budibase: " domaine
else
      domaine=$1
      echo 'domaine for budibase is '$domaine
fi

sed -i '/URL_BUDIBASE/c\URL_BUDIBASE='$domaine .env


secretjwt=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32)
echo $secretjwt
sed -i '/JWT_SECRET=/c\JWT_SECRET='$secretjwt .env

secretjwt=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 10)
echo $secretjwt
sed -i '/INTERNAL_API_KEY=/c\INTERNAL_API_KEY='$secretjwt .env

echo "For budibase stack url is https://"$domaine" jwt is "$secretjwt >> /tmp/toSendInfoByMail

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d

