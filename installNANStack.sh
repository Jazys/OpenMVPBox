#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

pushd n8n
./install-with-traefik.sh
popd

pushd appsmith
./install-with-traefik.sh
popd

pushd nocodb
./install-with-traefik.sh
popd

