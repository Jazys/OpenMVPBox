#!/bin/bash

./installRestService.sh $1

pushd traefik
./install.sh $1
popd

pushd portainer
./install.sh $2
popd


