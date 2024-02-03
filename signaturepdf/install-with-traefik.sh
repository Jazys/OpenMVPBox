#!/bin/bash
git clone https://github.com/24eme/signaturepdf.git
cp signaturepdf/* . -R
mkdir data

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for Signaturepdf: " domaine
else
      domaine=$1
      echo 'domaine for SignaturePDF is 'domaine
fi

sed -i '/URL_SIGNATURE/c\URL_SIGNATURE='$domaine .env

docker-compose -f docker-compose-with-traefik.yml up -d
