#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0
docker exec -ti penpot_penpot-backend_1 ./manage.sh create-profile
