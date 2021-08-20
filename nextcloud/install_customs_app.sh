#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

wget https://github.com/nextcloud/notes/releases/download/v4.1.1/notes.tar.gz
wget https://github.com/nextcloud/forms/releases/download/v2.3.0/forms.tar.gz
wget https://github.com/baimard/gestion/releases/download/1.0.4/gestion.tar.gz
wget https://github.com/pawelrojek/nextcloud-drawio/releases/download/v.1.0.1/drawio-v1.0.1.tar.gz
wget https://github.com/nextcloud-releases/deck/releases/download/v1.5.0/deck.tar.gz

tar xvf notes.tar.gz -C ./data/custom_apps
tar xvf forms.tar.gz -C ./data/custom_apps
tar xvf gestion.tar.gz -C ./data/custom_apps
tar xvf drawio-v1.0.1.tar.gz -C ./data/custom_apps
tar xvf deck.tar.gz -C ./data/custom_apps

