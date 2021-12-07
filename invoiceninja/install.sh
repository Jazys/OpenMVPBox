#!/bin/bash

mkdir -p config

git clone https://github.com/invoiceninja/dockerfiles.git
cd dockerfiles

chmod 755 docker/app/public
chown -R 1500:1500 docker/app

apkey=$(docker run --rm -it invoiceninja/invoiceninja php artisan key:generate --show)

echo $apkey

sed -i '/APP_KEY/c\APP_KEY='$apkey env
sed -i '/APP_URL/c\APP_URL=http:\/\/:0.0.0.0:8000' env
