#!/bin/bash

mkdir -p dataMongo
mkdir -p dataLemverse

domaine=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for lemverse: " domaine
else
      domaine=$1
      echo 'domaine for lemverse is '$domaine
fi

sed -i '/URL_LEMVERSE/c\URL_LEMVERSE='$domaine .env
sed -i '/URL_PEERJS/c\URL_PEERJS=peer.'$domaine .env

docker-compose -f docker-compose-omvpb.yml up -d 
