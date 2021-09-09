# OpenMVPBox

It's an environment which delivers some **no/low code software** for creating MVP/POC. You can choose your favorite stack.
OpenMVPBox can be hosted on **your local** server or on a **VPS**.
OpenMVPBox is **serverless**, all stacks are running with docker system. 

Minimal docker on your OpenMVPBox are :
* **Traefik** for creating redirection and secure connexion
* **Portainer** for managing your stack ( restart a docker for example)

**Easy to use !** 

OpenMVPBox is under **construction**.
Need had some stack, create script for deploying it easily, work on **global security** on your VPS

## Why OpenMVPBox

All no-code tools are proprietary, some free or not, but you can't manage tool and **data** yourself.
In some project, **data** are the key, so you need to host them. 

You can also use your tool in a offline environment, you can't with several no-code tools.

You can make your own developpement on the stack (hire a developper or use your hands), so you can adapt the solution, you can't in general with no-code tools.

Opensource tool have a really different approach, no raising money, so keep focus for create simple tool (no needs to manage money).

But for maintaining Opensource project, you must contribute :
* share information on social network
* make tests and describe it
* make contribution with coding
* make donation

## Available stack

Some stacks are not entirely integrated in a script

Stack:
- **parse** - **nocodb** - appwrite  -directus  ==> backend or database
- **penpot** ==> creating UI and mockup
- **n8n** - nodered (like for low-level industry) ==> create automation (my favorite tool)
- **silex** - **appsmith** ==> create web site or UI dashboard
- **grav** - **ghost** ==> create blog site
- **wikijs** - **codimd** - outline ==> share note and wiki
- **nextcloud** ==> manage/store file and CRM (note, invoice, kanban)
- **minio** ==> store/manage big file (like S3)
- discourse - flarum ==> Forum for discuss with client or prospect
- **automatTest** ==> special tool for making automate test Frontend or RESTAPI
- botpress ==> create your bot
- **carbonejs** ==> create your document pdf, doc, xls using template with RESTAPI (special stack)
- **mqtt** ==> a broker that
- **strapi** ==> your favorite headless CMS
- **traccar** ==> visualize position of object (for example vehicule)
- siberiancms ==> create your android, ios or pwa app

All tools are open-source and can be self-hosted.

For Non confidential data, use free online service :
- Calendar : use Calendly ou GoogleCalendar
- Password manager : use Bitwarden online (data are encrypted), can be exporterd (make it regularly).So don't worry to use it
Bitwarden can be use as self-hosted service but need to be manage and secure !!
- Jitsi : for realtime communication like GoogleMeet, Teams,.... You can use the online service or self hosted the service

For business contact : (not include)
- GoogleCalendar/Calendly ==> book a call
- Jisti ==> have a video call

Productivity : (not include)
- Bitwarden ==> Password Manager
- Gitlab ==> manage your source

## How to Use the OpenMVPBox on a VPS

## For normal person

### Domain Name creation
Create your domaine name using https://us.ovhcloud.com/.
Follow this link https://docs.ovh.com/fr/api/api-premiers-pas/ for creating your Token for creating dynammically subdomain (sorry for no-french people, see picture only).

### VPS creation
You can use your favorite provider, for me it's DigitalOcean.

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.digitaloceanspaces.com/WWW/Badge%203.svg)](https://www.digitalocean.com/?refcode=aeea1af961a4&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)

Click on this link for creating an account. It's a affiliate link, for help me to maintain OpenMVPBox, please use my referral link. For test, I need to create several droplets (so costing !).

For creating Droplet, use this link https://docs.digitalocean.com/products/droplets/how-to/create/
You need to



## For developper

Clone the project your VPS server (Ubuntu for the moment).

    cd OpenMVPBox
    ./makeScriptExec.sh
    ./installDocker.sh
    ./installManager.sh  (configure domaine name, login and password)

Use all script that you want in each directory.
* install.sh means your installation w
* install-with-traefik.sh means that you need to use the stack with traefik and domain name

## Stack available

- [x] NAN Stack for n8n, Appmith and NocoDB service ( use script ./installNANStack.sh in OpenMVPBox directory)
- [x] E2E Stack, a stack for writting and running test for WebAPP ( use script xxxx in OpenMVPBox directory)
- [] NAP Stack for n8n, Appmith and Parse Server service ( use script xxxx in OpenMVPBox directory)
- [] S2S Stack for Silex and Strapi service ( use script xxxx in OpenMVPBox directory)
- [] NAC Stack for n8n, Appsmith and CarboneJS ( use script xxxx in OpenMVPBox directory)
- [] PG Stack for Penpot and Grav service ( use script xxxx in OpenMVPBox directory)

