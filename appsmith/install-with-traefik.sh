#!/bin/bash

mkdir -p ./data/mongo/db

read -p "Indicate your domain for Appsmith: " domaineAppsmith
sed -i '/URL_APPSMITH/c\URL_APPSMITH='$domaineAppsmith'' docker.env

docker-compose -f docker-compose-with-traefik.yml --env-file docker.env up -d
