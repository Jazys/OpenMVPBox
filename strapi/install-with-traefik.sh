#!/bin/bash

mkdir -p postgres-data
mkdir -p app

docker-compose -f docker-compose-with-traefik.yml up -d 
