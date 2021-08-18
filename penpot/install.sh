#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

wget https://raw.githubusercontent.com/penpot/penpot/main/docker/images/docker-compose.yaml
wget https://raw.githubusercontent.com/penpot/penpot/main/docker/images/config.env

rm docker-compose.yaml
rm config.env

sed -i '1,2d' config.env

echo  "PENPOT_PUBLIC_URI=http://"$(hostname  -I | cut -f1 -d' ')":9001" >> config.env

