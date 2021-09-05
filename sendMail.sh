#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

export PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)

curl -s \
	-X POST \
	--user "$1:$2" \
	https://api.mailjet.com/v3.1/send \
	-H 'Content-Type: application/json' \
	-d '{
		"Messages":[
				{
						"From": {
								"Email": "jul38_9@hotmail.com",
								"Name": "OpenMVPBox Batisseur - contact@batisseurdunumerique.fr"
						},
						"To": [
								{
										"Email": "'"$3"'",
										"Name": "VPS OpenMVPBox"
								}
						],
						"Variables": {
								"IP": "'"$PUBLIC_IPV4"'"
						},
						"TemplateLanguage": true,
						"Subject": "Installation OpenMVPBox!",
						"TextPart": "Bonjour à toi, Bravo ton OpenMVPBox est prête, utilise IP suivant {{var:IP}},lie cette IP avec ton nom de domaine",
						"HTMLPart": "<h3>Bonjour à toi, Bravo ton <a href=\"https://github.com/Jazys/OpenMVPBox/\">OpenMVPBox</a> est prête ,</h3><br /> utilise IP suivante {{var:IP}},lie cette IP avec ton nom de domaine."
				}
		]
	}'
