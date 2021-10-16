#!/bin/bash

docker-compose build uniflow-api --build-arg UNIFLOW_VERSION="1.1.15"
docker-compose build uniflow-client --build-arg UNIFLOW_VERSION="1.1.15"
docker-compose up
