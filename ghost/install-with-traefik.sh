#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir mysql
read -p "Indicate your domain for ghost: " domaine
sed -i '/URL_GHOST/c\URL_GHOST='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d
