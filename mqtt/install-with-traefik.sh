#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir data
read -p "Indicate your domain for mqtt: " domaine
sed -i 's/URL_MQTT/URL_MQTT='$domaine'/g' .env

docker-compose -f docker-compose-with-traefik.yml up -d
