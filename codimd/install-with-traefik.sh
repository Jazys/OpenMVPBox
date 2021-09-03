#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir postgres-data
mkdir data
read -p "Indicate your domain for codi dashboard: " domaine
sed -i 's/URL_CODI/URL_CODI='$domaine'/g' .env
