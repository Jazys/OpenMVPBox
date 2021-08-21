
#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

sudo git clone https://github.com/discourse/discourse_docker.git 
cp discourse_docker/samples/standalone.yml discourse_docker/containers/app.yml
cd discourse_docker 
./launcher bootstrap app
