#!/bin/bash

domaine=""
url=""


if [ -z "$1" ]
then
      read -p "Indicate your url: " domaine
else
      domaine=$1
      echo 'domaine for pwa is '$domaine
      url=$2
      echo 'url is '$url
fi

if [ -z "$3" ]
then
      echo "default user id 1"
else
      sed -i '/USER_ID/c\USER_ID='$3 .env
fi

#grep -rl oldtext . | xargs sed -i 's/oldtext/newtext/g'

sed -i '/window.open/c\window.open("https://'$url'","_self");' data/index.html

sed -i '/URL_PWA=/c\URL_PWA='$domaine .env 


docker-compose -f docker-compose-with-traefik.yml up --build -d



