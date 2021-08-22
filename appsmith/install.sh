#!/bin/bash

mkdir -p ./data/mongo/db
docker-compose  --env-file docker.env up -d
