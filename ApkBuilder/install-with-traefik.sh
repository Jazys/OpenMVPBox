#!/bin/bash

chmod +x MyApp/gradlew
touch database.db

domaine=""
appUrl=""

rm MyApp/app/src/androidTest/ -R
rm MyApp/app/src/test -R

touch MyApp/app/build/.keep

if [ -z "$1" ]
then
      read -p "Indicate your url: " domaine
else
      domaine=$1
      echo 'domaine for getting apk is '$domaine
      appUrl=$2
fi

#grep -rl oldtext . | xargs sed -i 's/oldtext/newtext/g'

sed -i '/myWebView.loadUrl/c\myWebView.loadUrl("https://'$appUrl'");' MyApp/app/src/main/java/com/example/myapp/MainActivity.java
sed -i '/URL_APK=/c\URL_APK='$domaine .env 

docker-compose -f docker-compose-with-traefik.yml up --build -d

