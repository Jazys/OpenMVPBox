For using install of appwrite.
use this cmd :

docker run -it --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume "$(pwd)"/appwrite:/usr/src/code/appwrite:rw \
    --entrypoint="install" \
    appwrite/appwrite:0.9.3

Follow instructions

In docker-compose remove traefik and label in appwrite service, add port.

For using API :
curl -XGET -H 'X-Appwrite-Project: [MY-PROJECT-ID]' -H "Content-type: application/json" 'https://appwrite.io/v1/locale'
curl -XGET -H 'X-Appwrite-Project: [MY-PROJECT-ID]' -H 'X-Appwrite-key: [MY-API-KEY]' -H "Content-type: application/json" 'https://appwrite.io/v1/users'

See https://appwrite.io/docs/client/database for selecting your query in database.
