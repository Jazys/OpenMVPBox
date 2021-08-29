# OpenMVPBox

It's a Toobox which delivers some no/low stack four creating MVP/POC.

All tool are open-source and can be self-hosted

For Non confidential data, use free online service :
- Calendar : use Calendly ou GoogleCalendar
- Password manager : use Bitwarden online (data are encrypted), can be exporterd (make it regularly).So don't worry to use it
Bitwarden can be use as self-hosted service but need to be manage and secure !!
- Jitsi : for realtime communication like GoogleMeet, Teams,.... You can use the online service or self hosted the service

This toolbox become with docker system so it's serverless.

Treafik and portainer are the service for managing your toolbox.

Stack: (include)
- appwrite - nocodb  ==> backend or database
- penpot ==> creating UI and mockup
- n8n ==> create automation
- silex - appsmith ==> create web site or UI dashboard
- codimd - outline ==> share note and wiki
- nextcloud ==> manage/store file and CRM (note, invoice, kanban)
- minio ==> store/manage big file (like S3)
- discourse ==> Forum for discuss with client or prospect
- automatTest ==> special task for making automate test Frontend or RESTAPI

For business contact : (not include)
- GoogleCalendar/Calendly ==> book a call
- Jisti ==> have a video call

Productivity : (not include)
- Bitwarden ==> Password Manager
- Gitlab ==> manage your source

## Use the OpenMVPBox

Clone the project your VPS server (Ubuntu for the moment).

    cd OpenMVPBox
    ./makeScriptExec.sh
    ./installDocker.sh
    ./installManager.sh  (configure domaine name, login and password)

## Stack available

- [x] NAN Stack for n8n, Appmith and NocoDB service ( use script ./installNANStack.sh in OpenMVPBox directory)
- [x] E2E Stack, a stack for writting and running test for WebAPP ( use script xxxx in OpenMVPBox directory)
- [] NAP Stack for n8n, Appmith and Parse Server service ( use script xxxx in OpenMVPBox directory)
- [] S2S Stack for Silex and Strapi service ( use script xxxx in OpenMVPBox directory)
- [] NAC Stack for n8n, Appsmith and CarboneJS ( use script xxxx in OpenMVPBox directory)
- [] PG Stack for Penpot and Grav service ( use script xxxx in OpenMVPBox directory)

