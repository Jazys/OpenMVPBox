#!/bin/bash

mkdir -p data

#make better !!!
chmod 777 data/ -R

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for jupyter: " domaine
else
      domaine=$1
      echo 'domaine for jupyter is '$domaine
fi

sed -i '/URL_JUPYTER/c\URL_JUPYTER='$domaine .env

password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
echo "password généré" $password
sed -i '/TOKEN/c\TOKEN='$password .env

echo "Token  for "$domaine " is "$password " " >> /tmp/toSendInfoByMail


docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
