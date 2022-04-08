#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

apt-get install haveged -y
releaseVersion=$(cat /etc/*-release | grep DISTRIB_RELEASE)
apt update
sudo apt-get install apache2-utils -y
apt install apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release curl  -y

if [ "$releaseVersion" = "DISTRIB_RELEASE=21.04" ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    apt install docker.io -y
else
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable'
    apt install docker-ce -y
fi
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
#add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable'
apt update
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
