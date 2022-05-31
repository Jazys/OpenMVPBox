#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

pushd n8n-custom
./install-with-traefik.sh $1 $2 $3 $4
popd

pushd appsmith
./install-with-traefik.sh $5
popd

pushd grist
./install-with-traefik.sh $6
popd

