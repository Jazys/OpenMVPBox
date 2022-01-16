#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

mkdir -p /home/ubuntu/stacks

apkey=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 23)
echo $apkey

apkeyhash=$(htpasswd -nb -B admin $apkey | cut -d ":" -f 2)

echo "apkey for mananging stack via rest service "$apkeyhash
echo "apkey for mananging stack via rest service "$apkeyhash >> /tmp/toSendInfoByMail
echo $apkeyhash > /root/OpenMVPBox/apiKey

localip=$(ip -4 addr show enp3s0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

testEth1=$(ip a |grep eth1 | wc -l)

if (( testEth1 >= 1 )); then
  localip=$(ip -4 addr show eth1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
fi

testEnp3s0=$(ip a |grep enp3s0 | wc -l)

if (( testEnp3s0 >= 1 )); then
  localip=$(ip -4 addr show testEnp3s0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
fi

domaineName=$(echo $1 | cut --complement -d'.' -f 1)

sed -i 's/yyy.yyy/api.'$domaineName'/g' traefik/conf/traefik_dynamic.toml
sed -i 's/@ip/'$localip'/g' traefik/conf/traefik_dynamic.toml

sed -i 's/@ip/'$localip'/g' omvpb.py

cp omvpb.py /home/ubuntu/stacks
cp omvpb-back.service /etc/systemd/system

systemctl daemon-reload
systemctl enable omvpb-back.service
systemctl start omvpb-back.service

