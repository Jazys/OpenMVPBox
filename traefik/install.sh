#!/bin/bash
docker network create traefik-proxy
touch conf/acme.json
chmod 600 conf/acme.json
