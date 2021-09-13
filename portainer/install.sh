
#!/bin/bash
mkdir data
password=$(cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-20} | head -n 1)
echo "password généré" $password

#hash=$(htpasswd -bn test $password | cut -c6-)
#echo $hash
#passordReplace=$(echo "${hash//$/\$\$}")
#echo $passordReplace

passwordCmdPortainerDoc=$(htpasswd -nb -B admin $password | cut -d ":" -f 2)
echo $passwordCmdPortainerDoc
sed -i '/PASSWORD_PORTAINER=/c\PASSWORD_PORTAINER='$passwordCmdPortainerDoc'' .env

echo "Password pour le login admin de Portainer : " $password >> /tmp/mail
