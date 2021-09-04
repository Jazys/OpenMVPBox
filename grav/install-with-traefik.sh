#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir grav
read -p "Indicate your domain for grav: " domaineGrav
sed -i '/URL_GRAV/c\URL_GRAV='$domaineGrav .env

docker-compose -f docker-compose-with-traefik.yml up -d
