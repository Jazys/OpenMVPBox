
#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

./makeScriptExec.sh
./installDocker.sh
./installPythonPip.sh
./installManagerAutoLoginPass.sh 'traf.'$1 'portainer.'$1
