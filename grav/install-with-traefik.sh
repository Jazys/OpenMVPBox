#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir grav
read -p "Indicate your domain for grav: " domaineGrav
sed -i 's/URL_GRAV/URL_GRAV='$domaineGrav'/g' .env
