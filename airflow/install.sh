#!/bin/bash

mkdir -p data
mkdir -p data-postgres
mkdir -p plugins

docker build -t puckel/docker-airflow:2.0.0 .
docker-compose up -d
