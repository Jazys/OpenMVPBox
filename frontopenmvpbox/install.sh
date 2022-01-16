#!/bin/bash

git clone https://github.com/Jazys/FrontOpenMVPBox.git temp
mv temp/* .
rm -rf temp

touch .env
echo "URL_FRONT=front."$1 > .env
echo "VITE_URL_SRV=https://api."$1 >> .env
echo "NETWORK_TRAEFIK=traefik-proxy" >> .env

echo "Frontend https://front.'$domaineName' creditentials are same as traefik service ">> /tmp/toSendInfoByMail

docker-compose up -d

