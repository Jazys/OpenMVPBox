#!/bin/bash

mkdir -p data
mkdir -p data-filebro

touch database.db

cp conf-dash.yml data/config.yml

domaine=""
domaine2=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for dashboard: " domaine
else
      domaine=$1
      echo 'domaine for dashboard is '$domaine
fi

sed -i '/URL_DASH/c\URL_DASH='$domaine .env

password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
echo "password généré" $password
cred=$(echo $(htpasswd -nb admin $password) | sed -e s/\\$/\\$\\$/g)
echo "Login/admin for "$domaine " are admin and "$password " " >> /tmp/toSendInfoByMail

echo $cred
sed -i 's/$creditentials/'$cred'/g' docker-compose-with-traefik.yml

if [ -z "$2" ]
then
      read -p "Indicate your domain for filebrowser: " domaine2
else
      domaine2=$2
      echo 'domaine for filebrowser is '$domaine2
fi

sed -i '/URL_FILEBROSWER/c\URL_FILEBROSWER='$domaine2 .env

echo "Login/admin for "$domaine2 " are admin and admin  please change your password " >> /tmp/toSendInfoByMail

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
