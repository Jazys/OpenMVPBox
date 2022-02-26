#!/bin/bash

chmod +x MyApp/gradlew

domaine=""
appName=""

rm MyApp/app/src/androidTest/ -R
rm MyApp/app/src/test -R

if [ -z "$1" ]
then
      read -p "Indicate your url: " domaine
else
      domaine=$1
      echo 'domaine for tooljet is '$domaine
fi

#grep -rl oldtext . | xargs sed -i 's/oldtext/newtext/g'

sed -i '/myWebView.loadUrl/c\myWebView.loadUrl("https://'$domaine'");' MyApp/app/src/main/java/com/example/myapp/MainActivity.java

docker-compose up

cp MyApp/app/build/outputs/apk/release/app-release-unsigned.apk app-release-unsigned.apk


