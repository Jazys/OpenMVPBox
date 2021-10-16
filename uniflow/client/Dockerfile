FROM node:16.10

ARG UNIFLOW_VERSION

RUN if [ -z "$UNIFLOW_VERSION" ] ; then echo "The UNIFLOW_VERSION argument is missing!" ; exit 1; fi

RUN \
	apt-get update && \
	apt-get -y install git

# Set a custom user to not have uniflow run as root
USER root

RUN npm_config_user=root npm install -g @uniflow-io/uniflow-client@${UNIFLOW_VERSION}

WORKDIR /data

COPY .env .env.development
## quick path fix
RUN sed -i 's#./public#/usr/local/lib/node_modules/@uniflow-io/uniflow-client/public#g' /usr/local/lib/node_modules/@uniflow-io/uniflow-client/dist/uniflow-client/src/server.js
## quick envs fix
RUN sed -i 's#clientUrl:""#clientUrl:"http://localhost:8016"#g' /usr/local/lib/node_modules/@uniflow-io/uniflow-client/public/app-34a69f8d6e67a628485e.js
RUN sed -i 's#apiUrl:""#apiUrl:"http://localhost:8017"#g' /usr/local/lib/node_modules/@uniflow-io/uniflow-client/public/app-34a69f8d6e67a628485e.js

EXPOSE 8017/tcp
