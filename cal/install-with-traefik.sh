#!/bin/bash

mkdir -p data-postgres
git clone --recursive https://github.com/calendso/docker.git calendso
cp calendso/* . -R

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for calc: " domaine
else
      domaine=$1
      echo 'domaine for calc is '$domaine
fi

sed -i '/URL_CALC/c\URL_CALC='$domaine .env
sed -i '/URL_ADMIN_CONF/c\URL_ADMIN_CONF=conf-'$domaine .env

password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
#echo "password généré" $password
cred=$(echo $(htpasswd -nb admin $password) | sed -e s/\\$/\\$\\$/g)
echo "Login/admin for "$domaine " are admin and "$password " for conf-"$domaine
echo "Login/admin for "$domaine " are admin and "$password " " >> /tmp/toSendInfoByMail

#echo $cred
sed -i 's/$creditentials/'$cred'/g' docker-compose-with-traefik.yml

sed -i '/NEXT_PUBLIC_APP_URL/c\NEXT_PUBLIC_APP_URL=https://'$domaine .env

jwtcaldav=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20)
sed -i '/CALENDSO_ENCRYPTION_KEY=/c\CALENDSO_ENCRYPTION_KEY='$jwtcaldav .env

jwt=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 30)
sed -i '/JWT_SECRET=/c\JWT_SECRET='$jwt .env

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
