#!/bin/bash

ufw enable -y
ufw default deny incoming
ufw allow http
ufw allow https
