#!/bin/bash

./installDocker.sh
./installPythonPip.sh
./installManagerAutoLoginPass.sh 'traf.'$1 'portainer.'$1
