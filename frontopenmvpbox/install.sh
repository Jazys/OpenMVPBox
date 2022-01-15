#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

git clone https://github.com/Jazys/FrontOpenMVPBox.git temp
mv temp/* .
rm -rf temp
touch .env
echo "VITE_URL_SRV='http://185.189.156.201:9081'" > .env
docker-compose up -d

