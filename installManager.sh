#!/bin/bash

read -p "Indicate your domain for monitor traefik: " domaineTraefik
sed -i 's/xxx.xxx/'$domaineTraefik'/g' traefik/conf/traefik_dynamic.toml


read -p "Indicate login for monitor traefik: " loginTraefik
read -p "Indicate password for monitor traefik: " passTraefik

htpasswd -b -c ./password $loginTraefik $passTraefik

chmod +x replaceInFile.sh
EncryptedPassword=$( cat ./password)
echo $EncryptedPassword

#./replaceInFile.sh traefik/conf/traefik_dynamic.toml login:passcrypt $EncryptedPassword 
sed -i 's/login:passcrypt/'$EncryptedPassword'/g' traefik/conf/traefik_dynamic.toml
