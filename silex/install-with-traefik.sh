#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir data
mkdir data_website
read -p "Indicate your domain for silex: " domaineSilex
sed -i 's/URL_SILEX/URL_SILEX='$domaineSilex'/g' .env
