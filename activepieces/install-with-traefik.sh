#!/bin/bash
mkdir pg_data redis_data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for Activepieces: " domaine
else
      domaine=$1
      echo 'domaine for Activepiece is 'domaine
fi

sed -i '/AP_FRONTEND_URL/c\AP_FRONTEND_URL='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up

