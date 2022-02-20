#!/bin/bash

mkdir -p data-mysql
mkdir -p data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for wordpress: " domaine
else
      domaine=$1
      echo 'domaine for wordpress is '$domaine
fi

sed -i '/URL_WORDPRESS/c\URL_WORDPRESS='$domaine .env

echo "For wordpress stack url is https://"$domaine >> /tmp/toSendInfoByMail

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
