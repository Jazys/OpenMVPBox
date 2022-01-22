# OpenMVPBox

<p align="center"><img width="400" alt="Logo" src="https://i.ibb.co/NmX3hKN/front-Open-MVP.png"></p>

It's an environment that delivers some **no/low code software** for creating MVP/POC. You can choose your favorite stack.
OpenMVPBox can be hosted on **your local** server or on a **VPS**.
OpenMVPBox is **serverless**, all stacks are running with docker system. 

Minimal dockers on your OpenMVPBox are :
* **Traefik** for creating redirection and secured connexion
* **Portainer** for managing your stack ( restart a docker for example)
* **A service Rest Api** for creating stack directly with frontend (experimental) (available on api.yourdomainename)

These stacks are used for managing service in our VPS.

For minimal installation (root user for moment)

    wget https://raw.githubusercontent.com/Jazys/OpenMVPBox/main/omvp-setup.sh
    chmod +x ./omvp-setup.sh && sudo ./omvp-setup.sh mySubOrDomaineName (configure your DNS)

Read all console log to find creditentials and urls (https://front.mySubOrDomaineName for install stacks)
Ater choose your stack and run the installXX.sh script

**Easy to use !** 

OpenMVPBox is under **construction**( need to add stacks, to create scripts for deploying it easily, to improve **global security** on your VPS).

I also wrote some **articles in French** (video coming soon) where I explain **how to use** it and give **some templates**. It's an **entire eco-system for helping entrepreneur**.
Have a look at https://www.batisseurdunumerique.fr/blog/fr. Sorry, it's only available in French ...

Give me some feedbacks:
* for French people : https://cloud.batisseurdunumerique.fr/apps/forms/xQLZQXCJwkF7pFXg
* for non French people : https://cloud.batisseurdunumerique.fr/apps/forms/GDgyyMbmEteccRmB

## Why OpenMVPBox

All no-code tools are proprietary, some are free, but you can't manage your tools and **datas** by yourself.
In some projects, **datas** are the key, so you need to host them. 

You may also want to use your tool in an offline environment, you can't with several no-code tools.

You can make your own developpement on the stack (hire a developper or use your hands), so you can improve the solution, which you generally can't do with no-code tools.

Opensource tools have a really different approach, no raising money, so keep focused to create simple tools (no need to manage money).

For maintaining an Opensource project, you can contribute :
* share informations on social networks
* make tests and describe them
* make contributions with coding
* make donations

## Available stack

Some stacks are not entirely integrated in a script

Stack:
- **parse** - **nocodb** -**supabase**- appwrite  -directus  ==> backend or database
- **matermost** ==> to collaborate with your team and audience (alternative to slack)
- **penpot** ==> creating UI and mockup
- **n8n** - nodered (like for low-level industry) ==> create automation (my favorite tool)
- **uniflow** - Automate your recurring tasks once, run it everywhere. (default account : admin@uniflow.io / admin)
- **silex** - **appsmith** ==> create web site or UI dashboard
- **wordpress** - **grav** - **ghost** ==> create blog site
- **focalboard** ==> share note
- **wikijs** - **codimd** - **docusaurus** - outline ==> share note and wiki
- **nextcloud** ==> manage/store file and CRM (note, invoice, kanban)
- **minio** ==> store/manage big file (like S3)
- **calc** ==> to share your calendar
- **jitsi** ==> for video conference
- discourse - flarum ==> Forum for discuss with client or prospect
- **automatTest** ==> special tool for making automate test Frontend or RESTAPI
- **botpress** ==> create your bot
- **carbonejs** ==> create your document pdf, doc, xls using template with RESTAPI (special stack)
- **mqtt** ==> a broker that
- **strapi** ==> your favorite headless CMS
- **traccar** ==> visualize position of object (for example vehicule)
- siberiancms ==> create your android, ios or pwa app

All tools are open-source and can be self-hosted.

For Non confidential data, use free online service :
- Calendar : use Calendly ou GoogleCalendar or calc.com
- Password manager : use Bitwarden online (data are encrypted), can be exporterd (make it regularly).Don't be worried to use it
Bitwarden can be used as a self-hosted service but need to be managed and secured !!
- Jitsi : for realtime communication like GoogleMeet, Teams,.... You can use the online service or self hosted service

For business contact : (included)
- Calc/GoogleCalendar/Calendly ==> book a call
- Jisti ==> have a video call

Productivity : (not include)
- Bitwarden ==> Password Manager
- Gitlab ==> manage your source

## How to Use the OpenMVPBox on a VPS

## For normal person 

### Domain Name creation
Create your domaine name using https://us.ovhcloud.com/.
Follow this link https://docs.ovh.com/fr/api/api-premiers-pas/ for creating your Token that allows you to create dynammically subdomains (sorry for non-French people, have a look at the picture only).
Or use your preferred provider.

### VPS creation
You can use your favorite provider, for me it's DigitalOcean.

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.digitaloceanspaces.com/WWW/Badge%203.svg)](https://www.digitalocean.com/?refcode=aeea1af961a4&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)

Click on this link for creating an account. It's a affiliate link, to help me maintaining OpenMVPBox, please use my referral link. For tests, I need to create several droplets (so expensive !).

Use this link **https://omvpb.ovh/#/** for having a guide on how to create OpenMVPBox. **(really recommended)**

Or If you don't want use external service for creating it, and use only DO dashboard
For creating Droplet, use this link https://docs.digitalocean.com/products/droplets/how-to/create/
You need to use **Ubuntu** Distribution.
Choose a strong password or SSH key (if you know it, it's safer)
You need to check **userdata** and enter for example, the following script :

    #!/bin/bash 
    cd /root 
    git clone https://github.com/Jazys/OpenMVPBox.git 
    cd OpenMVPBox/ 
    chmod +x makeScriptExec.sh 
    ./makeScriptExec.sh 
    ./installDocker.sh 
    ./installPythonPip.sh 
    python3 createSubDomainOvh.py ton_Application_Key Ton_Application_Secret Ton_Consumer_Key tonNomDeDomaine *.tonSousDomaine $PUBLIC_IPV4 
    ./installManager.sh ndd_traefik login_dashboard_traefik password_dashboard_traefik ndd_portainer 
    ./installNANStack.sh ndd_n8n ndd_appsmith ndd_nocodb

Wait a few minutes and the service will start on your subdomain

Defautl login/password :
* portainer : create an account !! (not forget it)
* for n8n : test/test
* for appsmith : test@test.fr (user)
* for nocodb : create your password

Each directory the .env file includes your login/password.

## For developper

Clone the project on your VPS server (Ubuntu for the moment).

For minimal installation (root user for moment)

    cd /root && git clone https://github.com/Jazys/OpenMVPBox.git && cd OpenMVPBox  
    chmod +x makeScriptExec.sh && ./automaticInstall.sh SubDomainOrDomain

Read in console, the different password
Credidentials information are in /tmp/toSendByMail 

    cd OpenMVPBox
    chmod +x makeScriptExec
    ./makeScriptExec.sh
    ./installDocker.sh
    ./installPythonPip.sh
    export PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
    python3 createSubDomainOvh.py appKeyOVH "appSecretOVH consumerKeyOVH domainName subDomain $PUBLIC_IPV4
    ./installDocker.sh
    ./installManager.sh traefikSubDomain loginTraefik passwordTraefik portainerSubDomain
    OR
    ./installManagerAutoLoginPass.sh traefikSubDomain portainerSubDomain
    Credidentials information are in /tmp/toSendByMail 

Use any script that you want in each directory.
* install.sh means you install with local docker-compose (use port and public ip)
* install-with-traefik.sh means that you need to use the stack with traefik and domain name

## Stack can be deployed easily

- [x] NAN Stack for n8n, Appmith and NocoDB service ( use script ./installNANStack.sh in OpenMVPBox directory)
- [x] E2E Stack, a stack for writting and running test for WebAPP ( use script xxxx in OpenMVPBox directory)
- [ ] NAP Stack for n8n, Appmith and Parse Server service ( use script xxxx in OpenMVPBox directory)
- [ ] S2S Stack for Silex and Strapi service ( use script xxxx in OpenMVPBox directory)
- [ ] NAC Stack for n8n, Appsmith and CarboneJS ( use script xxxx in OpenMVPBox directory)
- [ ] PG Stack for Penpot and Grav service ( use script xxxx in OpenMVPBox directory)

