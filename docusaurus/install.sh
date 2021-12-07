#!/bin/bash

mkdir -p config
touch database.db

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for docusaurus: " domaine
else
      domaine=$1
      echo 'domaine for docusaurus is '$domaine
fi

sed -i '/URL_DOCUSAURUS/c\URL_DOCUSAURUS='$domaine .env

password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
echo "password généré" $password
cred=$(echo $(htpasswd -nb admin $password) | sed -e s/\\$/\\$\\$/g)

echo $cred
sed -i 's/$creditentials/'$cred'/g' docker-compose-with-traefik.yml

echo "Login/admin for dev."$domaine " are admin and "$password " " >> /tmp/toSendInfoByMail
echo "You can broswe file with file."$domaine " admin/admin are the credidentials, please change tehm " >> /tmp/toSendInfoByMail

docker-compose up -d

sleep 60

docker-compose down

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
