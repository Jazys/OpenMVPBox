#!/bin/bash

mkdir -p data-postgres

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for supabase: " domaine
else
      domaine=$1
      echo 'domaine for supabase is '$domaine
fi

sed -i '/URL_SUPABASE_FRONT/c\URL_SUPABASE_FRONT='$domaine .env
sed -i '/URL_SUPABASE_BACK/c\URL_SUPABASE_BACK=back-'$domaine .env

cred="/"
echo $(echo $cred | grep / | wc -l)
while [ $(echo $cred | grep / | wc -l) == 1 ]
do
   password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
   echo "password généré" $password
   cred=$(echo $(htpasswd -nb admin $password) | sed -e s/\\$/\\$\\$/g)
   echo $cred
done

echo "Login/admin for "$domaine " are admin and "$password " " >> /tmp/toSendInfoByMail

echo $cred
sed -i 's/$creditentials/'$cred'/g' docker-compose-with-traefik.yml

#generate jwt for anion and service
secretjwt=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32)
anon_key=$(./gen_jwt.sh $secretjwt anon)
service_role_key=$(./gen_jwt.sh $secretjwt service_role)
echo $anon_key
echo $service_role_key

sed -i '/JWT_SECRET=/c\JWT_SECRET='$secretjwt .env
sed -i '/ANON_KEY=/c\ANON_KEY='$anon_key .env
sed -i '/SERVICE_ROLE_KEY/c\SERVICE_ROLE_KEY='$service_role_key .env

sed -i 's/$anon/'$anon_key'/g' volumes/api/kong.yml
sed -i 's/$service_role/'$service_role_key'/g' volumes/api/kong.yml


docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d
