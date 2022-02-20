#!/bin/bash

mkdir -p postgres-data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for tooljet: " domaine
else
      domaine=$1
      echo 'domaine for tooljet is '$domaine
fi

sed -i '/URL_TOOLJET/c\URL_TOOLJET='$domaine .env
sed -i '/TOOLJET_HOST/c\TOOLJET_HOST=https://'$domaine .env

passkey=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 30 ; echo '')
masterkey=$(tr -dc 0-9 </dev/urandom | head -c 50 ; echo '')
sed -i '/SECRET_KEY_BASE/c\SECRET_KEY_BASE='$passkey .env
sed -i '/LOCKBOX_MASTER_KEY/c\LOCKBOX_MASTER_KEY='$masterkey .env


docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d

sleep 60

docker-compose -f docker-compose-with-traefik.yml run server npm run db:seed

echo "For tooljet stack url is https://"$domaine >> /tmp/toSendInfoByMail