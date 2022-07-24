#!/bin/bash

rm -rf NFT-Minter
git clone https://github.com/Jazys/NFT-Minter.git

if [ -z "$1" ]
then
      read -p "Indicate your url: " domaine
else
      domaine=$1
      echo 'domaine for template nft is '$domaine
fi

if [ -z "$2" ]
then
      echo "default user id 1"
else
      sed -i '/USER_ID/c\USER_ID='$2 .env
fi

sed -i '/URL_NFT_HOTRELOAD=/c\URL_NFT_HOTRELOAD='$domaine .env 

docker-compose -f docker-compose-with-traefik.yml up --build -d



