#!/bin/bash

docker network create traefik-proxy
touch conf/acme.json
chmod 600 conf/acme.json

loginTraefik="admin"
domaineTraefik=""

password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
echo "password généré" $password

if [ -z "$1" ]
then
      read -p "Indicate your domain for treafik: " domaineTraefik
else
      domaineTraefik=$1
      echo 'domaine for traefik is '$domaineTraefik
fi

sed -i 's/xxx.xxx/'$domaineTraefik'/g' conf/traefik_dynamic.toml

echo "Login/admin for https://"$domaineTraefik " are "$loginTraefik " and "$password " " >> /tmp/toSendInfoByMail

htpasswd -b -c password $loginTraefik $password

EncryptedPassword=$( cat ./password)
echo $EncryptedPassword

sed -i '/admin/c\"'$EncryptedPassword'"' conf/traefik_dynamic.toml

rm ./password


docker-compose up -d
