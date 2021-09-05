#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

pushd n8n
./install-with-traefik.sh $1
popd

pushd appsmith
./install-with-traefik.sh $2
popd

pushd nocodb
./install-with-traefik.sh $3
popd

