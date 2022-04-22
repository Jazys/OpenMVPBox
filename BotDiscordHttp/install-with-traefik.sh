#!/bin/bash
domaine=""
public_key=""
webhook_url=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for botdiscord: " domaine
else
      domaine=$1
      echo 'domaine for botdiscord is '$domaine
fi

if [ -z "$2" ]
then
      read -p "Indicate your domain for pulic-key: " public_key
else
      public_key=$2
      echo 'domaine for pulic-key is '$public_key
fi

if [ -z "$3" ]
then
      echo "no url provided"
else
      webhook_url=$3
      echo 'domaine for webhook is '$webhook_url
fi

sed -i '/URL_BOT/c\URL_BOT='$domaine .env
sed -i '/PUBLIC_KEY/c\PUBLIC_KEY='$public_key .env
sed -i '/URL_WEBHOOK/c\URL_WEBHOOK='$webhook_url .env

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d