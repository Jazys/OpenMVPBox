#!/bin/bash

chmod +x traefik/install.sh
./traefik/install.sh

read -p "Indicate your domain for monitor traefik: " domaineTraefik
sed -i 's/xxx.xxx/'$domaineTraefik'/g' traefik/conf/traefik_dynamic.toml


read -p "Indicate login for monitor traefik: " loginTraefik
read -p "Indicate password for monitor traefik: " passTraefik

htpasswd -b -c ./password $loginTraefik $passTraefik

chmod +x replaceInFile.sh
EncryptedPassword=$( cat ./password)
echo $EncryptedPassword

#./replaceInFile.sh traefik/conf/traefik_dynamic.toml login:passcrypt $EncryptedPassword 
sed -i 's/login:passcrypt/'$EncryptedPassword'/g' traefik/conf/traefik_dynamic.toml

rm ./password

read -p "Indicate your domain for portainer: " domainePortainer
sed -i '/URL_PORTAINER/c\URL_PORTAINER = '$domainePortainer'' portainer/.env
mkdir -p portainer/data

docker-compose -f traefik/docker-compose.yml --env-file traefik/.env up -d
docker-compose -f portainer/docker-compose.yml --env-file portainer/.env up -d
