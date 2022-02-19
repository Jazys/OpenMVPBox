#!/bin/bash

mkdir -p data-postgres
mkdir -p media

git clone https://gitlab.com/bramw/baserow.git baserow

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for baserow: " domaine
else
      domaine=$1
      echo 'domaine for baserow is '$domaine
fi

sed -i '/PUBLIC_WEB_FRONTEND_URL/c\PUBLIC_WEB_FRONTEND_URL='$domaine .env
sed -i '/PUBLIC_BACKEND_URL/c\PUBLIC_BACKEND_URL=back.'$domaine .env
sed -i '/PUBLIC_MEDIA_URL/c\PUBLIC_MEDIA_URL=media.'$domaine .env

echo "For baserow stack url is https://"$domaine> /tmp/toSendInfoByMail

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
