#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir postgres-data
read -p "Indicate your domain for geoloc dashboard: " domaine
sed -i 's/TRACCAR_URL/TRACCAR_URL='$domaine'/g' .env
