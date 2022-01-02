#!/bin/bash

cd /root
git clone https://github.com/Jazys/OpenMVPBox.git

cd OpenMVPBox/
chmod +x makeScriptExec.sh
./makeScriptExec.sh
./installDocker.sh
./installManager.sh ndd_traefik login_dashboard_traefik password_dashboard_traefik ndd_portainer
./installNANStack.sh ndd_n8n ndd_appsmith ndd_nocodb
./sendMail.sh key_public_mailjet key_private_mailjet dest_email
