#!/bin/bash

mkdir -p data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for codeserver: " domaine
else
      domaine=$1
      echo 'domaine for codeserver is '$domaine
fi

sed -i '/URL_CODESERVER/c\URL_CODESERVER='$domaine .env

password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
echo "password généré" $password
cred=$(echo $(htpasswd -nb admin $password) | sed -e s/\\$/\\$\\$/g)
echo "Password for "$domaine " is "$password " " >> /tmp/toSendInfoByMail

sed -i '/PASSWORD/c\PASSWORD='$password .env


docker-compose up -d
