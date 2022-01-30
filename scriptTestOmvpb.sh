#!/bin/bash

docker kill $(docker container ls -q)
yes | docker system prune -y
rm -R omvp-setup.sh stacks/
rm -R /root/OpenMVPBox
wget https://raw.githubusercontent.com/Jazys/OpenMVPBox/main/omvp-setup.sh
chmod +x ./omvp-setup.sh
./omvp-setup.sh nuage10.omvpb.ovh
systemctl restart omvpb-back
