#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir postgres-data
read -p "Indicate your domain for geoloc dashboard: " domaine
sed -i '/URL_TRACCAR/c\URL_TRACCAR='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d
