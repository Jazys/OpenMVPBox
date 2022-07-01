#!/bin/bash
domaine=""
public_key=""
webhook_url=""
application_id=""
token=""
guild_id=""
api_key=""

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
      echo "no api key provided"
else
      api_key=$3
      echo 'api key is '$api_key
fi

if [ -z "$4" ]
then
      echo "no url provided"
else
      webhook_url=$4
      echo 'domaine for webhook is '$webhook_url
fi

if [ -z "$5" ]
then
      echo "default user id 1"
else
      sed -i '/USER_ID/c\USER_ID='$5 .env
fi

if [ -z "$6" ]
then
      echo "no app id"
else
      application_id=$6
      echo 'app id is '$application_id
fi

if [ -z "$7" ]
then
      echo "no token provided"
else
      token=$7
      echo 'token is '$token
fi

if [ -z "$8" ]
then
      echo "no guild id provided"
else
      guild_id=$8
      echo 'guild id is '$guild_id
fi



sed -i '/URL_BOT/c\URL_BOT='$domaine .env
sed -i '/PUBLIC_KEY/c\PUBLIC_KEY='$public_key .env
sed -i '/APPLICATION_ID/c\APPLICATION_ID='$application_id .env
sed -i '/TOKEN/c\TOKEN='$token .env
sed -i '/GUILD_ID/c\GUILD_ID='$guild_id .env
sed -i '/API_KEY/c\API_KEY='$api_key .env
sed -i '/URL_WEBHOOK/c\URL_WEBHOOK='$webhook_url .env

docker-compose -f docker-compose-with-traefik.yml --env-file .env up -d