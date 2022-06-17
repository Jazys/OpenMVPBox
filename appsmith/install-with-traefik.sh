#!/bin/bash

mkdir -p ./data/mongo/db

domaineAppsmith=""
emailAdmin=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for Appsmith: " domaineAppsmith
else
      domaineAppsmith=$1
      echo 'domaine for appsmith is 'domaineAppsmith
fi
sed -i '/URL_APPSMITH/c\URL_APPSMITH='$domaineAppsmith'' .env


if [ -z "$2" ]
then
      read -p "Indicate Email admin : " emailAdmin
else
      emailAdmin=$2
      echo 'Email admin is ' $emailAdmin
fi

sed -i '/APPSMITH_ADMIN_EMAILS/c\APPSMITH_ADMIN_EMAILS='$emailAdmin'' .env

if [ -z "$3" ]
then
      echo "default user id 1"
else
      sed -i '/USER_ID/c\USER_ID='$3 .env
fi

echo "Email login  for https://"$domaineAppsmith " is "$emailAdmin " " >> /tmp/toSendInfoByMail

docker-compose -f docker-compose-with-traefik.yml up -d
