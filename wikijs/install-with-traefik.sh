#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p postgres-data

read -p "Indicate your domain for wiki : " domaine
sed -i '/URL_WIKI=/c\URL_WIKI='$domaine .env 



docker-compose -f docker-compose-with-traefik.yml up -d
