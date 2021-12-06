#!/bin/bash

mkdir -p data
mkdir -p data-mysql
mkdir -p data-nginx
domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for flarum: " domaine
else
      domaine=$1
      echo 'domaine for flarum is '$domaine
fi

sed -i '/URL_FLARUM=/c\URL_FLARUM='$domaine .env
sed -i '/FORUM_URL=/c\FORUM_URL=https:\/\/'$domaine .env

echo "Login/admin for "$domaine " are admin and admin@1234  please change your password " >> /tmp/toSendInfoByMail


docker-compose up -d
sleep 20
docker-compose down
sleep 5
docker-compose up -d




