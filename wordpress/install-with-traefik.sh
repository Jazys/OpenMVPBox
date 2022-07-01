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

if [ -z "$2" ]
then
      echo "default user id 1"
else
      sed -i '/USER_ID/c\USER_ID='$2 .env
fi

sed -i '/URL_WORDPRESS/c\URL_WORDPRESS='$domaine .env

echo "For wordpress stack url is https://"$domaine " login are admin/admin please change it !">> /tmp/toSendInfoByMail

docker-compose -f docker-compose-with-traefik.yml --env-file .env up --build -d
