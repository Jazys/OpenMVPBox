# Sibebrian CMS SAE docker image

[![LICENSE: MIT](https://img.shields.io/github/license/rylorin/docker-siberiancms)](https://raw.githubusercontent.com/rylorin/docker-siberiancms/master/LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/rylorin/docker-siberiancms)](https://github.com/rylorin/docker-siberiancms/graphs/contributors)

![Docker Automated build](https://img.shields.io/docker/automated/rylorin/siberiancms.svg) ![Docker Build Status](https://img.shields.io/docker/build/rylorin/siberiancms.svg) ![Docker Stars](https://img.shields.io/docker/stars/rylorin/siberiancms.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/rylorin/siberiancms.svg)

## About this image

This image contains the stuff needed to run a Siberian CMS SAE host.
The source [Dockerfile](https://github.com/rylorin/docker-siberiancms/blob/master/Dockerfile) and context for build are available at [https://github.com/rylorin/docker-siberiancms](https://github.com/rylorin/docker-siberiancms).

I based this image as much as possible on official images. I chose php:7.3-apache which is the closest from Siberian requirements. Then added java support, using a raw copy of official openjdk script. Last step added libraries and PHP modules required for Siberian CMS.


## Installation

Installation should be straight forward by using this image in a docker stack.

Docker compose example:

	version: '3.7'
	services:
	  mysql:
	    image: mariadb:10.5
	    environment:
	      MYSQL_ALLOW_EMPTY_PASSWORD: 'yes'
	      MYSQL_DATABASE: siberian
	      MYSQL_USER: siberian
	      MYSQL_PASSWORD: siberian
	    volumes:
	      - db:/var/lib/mysql:rw
	    deploy:
	      placement:
	        constraints:
	          - node.platform.os == linux
	  web:
	    image: rylorin/siberiancms:latest
	    depends_on:
	      - mysql
	    deploy:
	      placement:
	        constraints:
	          - node.platform.os == linux
	    volumes:
	      - htdocs:/var/www/html:rw
	    ports:
	        - 80:80/tcp
	volumes:
	  db:
	  htdocs:

You may need to bind the server on a different port if 80 is already in use on your server.
Then point your browser to your host.
If you have a multihost installation (ex. swarm installation) you may need to add deploy constraints to always launch the containers or the same host or you will be unable to access your volumes content.

It took me some time to build this image therefore I hope it will help you. Please don't hesitate to report problems.
Have fun with Siberian CMS!
