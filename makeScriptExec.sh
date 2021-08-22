
#!/bin/bash

[ `whoami` = root ] || exec sudo su -c $0

chmod +x *.sh */*.sh

