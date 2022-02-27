#!/bin/bash

domaine=""


if [ -z "$1" ]
then
      read -p "Indicate your url: " domaine
else
      domaine=$1
      echo 'domaine for pwa is '$domaine
fi

#grep -rl oldtext . | xargs sed -i 's/oldtext/newtext/g'

sed -i '/window.open/c\window.open("https://'$domaine'","_self");' data/index.html

docker-compose up --build



