#!/bin/bash

mkdir -p data
mkdir -p data-filebro

touch database.db

cp conf-dash.yml data/config.yml

docker-compose up -d