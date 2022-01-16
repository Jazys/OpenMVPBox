
#!/bin/bash
mkdir data

domainePortainer=""

if [ -z "$1" ]
then
      read -p "Indicate your domain for portainer: " domainePortainer
else
      domainePortainer=$1
      echo 'Domaine of portainer is ' $domainePortainer
fi

sed -i '/URL_PORTAINER/c\URL_PORTAINER = '$domainePortainer'' .env

password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
echo "password généré" $password

passwordCmdPortainerDoc=$(htpasswd -nb -B admin $password | cut -d ":" -f 2)
echo $passwordCmdPortainerDoc
sed -i '/PASSWORD_PORTAINER=/c\PASSWORD_PORTAINER='$passwordCmdPortainerDoc'' .env

echo "Login/admin for https://"$domainePortainer " are admin and "$password " " >> /tmp/toSendInfoByMail



docker-compose up -d
