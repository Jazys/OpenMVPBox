#!/bin/bash

touch database.db
domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for CarboneJs: " domaine
else
      domaine=$1
      echo 'domaine for CarboneJs is '$domaine
fi

sed -i '/URL_CARBONE=/c\URL_CARBONE='$domaine .env 

echo "Login/admin for browsing file is https://file."$domaine " are admin and admin " >> /tmp/toSendInfoByMail
echo "You can use POST Request in JSON to https://"$domaine ". See README for example" >> /tmp/toSendInfoByMail

docker-compose -f docker-compose-with-traefik.yml up -d
