---
author: "Cristian Mosquera"
title: "Docker Compose"
date: 2020-05-30T18:08:28-04:00
lastmod: 2020-05-30T18:08:28-04:00
description: "Docker compose sample: network, service definition, .env"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- docker-compose
- docker
- network
- demo
- services
---

# Dockerfiles with common network layer: Master-slave setup

## Instructions

* Configure values in .env file
* Init sequence:
  - Spin master first (See cmd 1)
  - Spin slave second (See cmd 1)
* Docker tear down instructions:
  - Stop + rm slave container first. Do not run dk-cp down (See cmd 2)
  - Down master script. It will manage the network teardown (See cmd 3)
* If slave container needs to be re-built and spin up again: Init only slave
* If master container needs to be re-built and spin up again: Follow init sequence

### Sample commands:
1. `docker-compose -f docker-compose.yml -f docker-compose.tandem.yml up --build -d`
2. `docker-compose stop && docker-compose rm -f`
3. `docker-compose -f docker-compose.yml -f docker-compose.tandem.yml down`

## Standard .env file

```
## docker-compose will extract the variables from this file
## If variable is not defined here, it needs to be defined in terminal 
## session running docker-compose. Any variable define in current session
## will superseed values defined here. Nevertheless, env variable 
## needs to be explicitely defined and read in the docker-compose file
##

SVC_PORT=8081
#COMPOSE_PROJECT_NAME=name_folder_where_master_is   ## You need this variable in the slave

CONFIG_VERSION=latest
SVC_ENVIRONMENT=dev

DOCKERFILE=./Dockerfile


BASE_REPO_PATH=/d/repo/folder
FOLDER_NAME_01=service_core
FOLDER_NAME_01=svc_name
MAIN_SVC_NAME=svc_name_main

#CRED_WINDOWS_CONFIG_PATH=/d/.credential
#OTHER_ENV_VAR_TO_USE=/

## Next can be setup here or in terminal session locally
SVC_LOGS_FOLDER_PATH=/
AUX_SVC_ADDR=0.0.0.0

```

## MASTER docker-compose.yml file

```
version: '3.4'

x-bucket-path:
  &default-bucket-svc-path
  "${FOLDER_NAME_01}/${FOLDER_NAME_02}/config/${CONFIG_VERSION}/${SVC_ENVIRONMENT}"

x-volumes: # Relative paths doesn't work with WSL and docker for Windows
  &default-volumes
  - type: bind
    source: ${BASE_REPO_PATH:?"BASE_REPO_PATH needs to be set, 'D:/git-repos' is an example. This is used for Docker for windows with Windows Linux SubSystem binded volumes in your container.  Uncomment voume If you don't want them or create a shadow d-c yaml file"}/${FOLDER_NAME_01}/${FOLDER_NAME_02}/${MAIN_SVC_NAME}
    target: /${MAIN_SVC_NAME}
  - type: bind
    source: ${BASE_REPO_PATH:?"BASE_REPO_PATH needs to be set, 'D:/git-repos' is an example. This is used for Docker for windows with Windows Linux SubSystem binded volumes in your container.  Uncomment voume If you don't want them or create a shadow d-c yaml file"}/${FOLDER_NAME_01}/${FOLDER_NAME_02}/${MAIN_SVC_NAME}-config
    target: /${MAIN_SVC_NAME}-config
  - type: bind
    source: ${CRED_WINDOWS_CONFIG_PATH:?"CRED_WINDOWS_CONFIG_PATH is unset, 'C:/Users/username/.credential' is an example.  This is used for Docker for windows with WSL binded volumes in your container.  Uncomment this volume if you don't want them"}
    target: "/root/.credential"

x-args:
  &default-args
  http_proxy: "http://yourproxy.org:port"
  https_proxy: "http://yourproxy.org:port"
  no_proxy: "localhost, 127.0.0.1"

x-environment:
    &default-env
    SVC_ENVIRONMENT: ${SVC_ENVIRONMENT}
    CRED_CONFIG_PATH: "/root/.credential"
    SVC_LOGS_FOLDER_PATH: "${MAIN_SVC_NAME}/logs"
    CONFIG_VERSION: ${CONFIG_VERSION}
    CONFIG_SVC_BUCKET: "bucket-name-for-svc"
    CONFIG_SVC_BUCKET_PATH: *default-bucket-svc-path
    AUX_SVC_ADDR: ${AUX_SVC_ADDR:?"AUX_SVC_ADDR is unset. You should have example to `example`"}

services:
  main-dev:
    build:
      args:
        *default-args
    environment:
      << : *default-env
      OTHER_ENV_VAR: ${OTHER_ENV_VAR_TO_USE:?"OTHER_ENV_VAR_TO_USE is unset. 'dflt-value' is an example"}
    volumes:
      *default-volumes
    networks:
      - svc_net

  aux-svc:
    image: aux_svc_image:latest
    ports:
      - 'svc_port:svc_port'
    networks:
      - svc_net

  main-test:
    build:
      args:
        *default-args
    environment:
      OTHER_ENV_VAR: ${OTHER_ENV_VAR_TO_USE:?"OTHER_ENV_VAR_TO_USE is unset. 'dflt-value' is an example"}
    volumes: # Relative paths doesn't work with WSL and docker for windows
      *default-volumes

networks:
  svc_net:
    driver: bridge

```

## Additional lines for SLAVE docker-compose.yml file

```
networks:
  my_net:
    external:
      name: ${COMPOSE_PROJECT_NAME}_my_net
```

## Sample defining other services in docker-compose file

```
services:
  redis:
    image: redis
    volumes:
      *default-volumes
    ports:
      - '6379:6379'
    networks:
      - my_net

  db:
    image: mongo:latest
    command: mongod --port 27018
    ports:
      - '27018:27018'
    networks:
      - my_net

  mysql:
    image: mysql
    container_name: mysql
    volumes:
      - mysql:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=root
      - MYSQL_DATABASE=ghost
      - MYSQL_USER=ghost
      - MYSQL_PASSWORD=password
    networks:
      - db

volumes:
 mysql:

```

* Example Dockerize PostgreSQL:  https://docs.docker.com/engine/examples/postgresql_service/

## Handy commands for debugging

* Shows all running containers: `docker ps -a`
* Removes idle stopped containers: `docker rm $(docker ps -q -f "status=exited")`
* See logs from container (name as displayed in docker ps): `docker logs -f {containerName}`
* Sh into a container: `docker exec -it {containerName} /bin/bash`
* To explore/beautify logs in container and extract loglevel and message and assign it to **LEVEL** and **MSG** resp.: `cat app_logs.txt | jq ". | {LEVEL: .logLevel, MSG: .message}"`
* To see the network bridges: `docker network ls`

## Overriding docker-compose

```
# This file  will override the docker-compose.yml
# Currently overrrides only any mounted volumes because they don't exist when deployed
# The way the override work with volume  : it override the volume with a different 
# source but the same destination path

version: '3.4'

x-args:
  &default-args
  http_proxy: ""
  https_proxy: ""
  no_proxy: ""
x-environment:
    &default-env
    << : *default-args
    REMOTE_SERVICE_USE_PUBLIC_IP: "false"
#Next modified previously defined volumes
x-volumes: # Relative paths doesn't work with WSL and docker for windows
  &default-volumes
  - type: bind
    source: /dir
    target: /${MAIN_SVC_NAME}
  - type: bind
    source: /dir
    target: /${MAIN_SVC_NAME}-config
  - type: bind
    source: /dir
    target: "/app/.credential"
#Here we apply the change by replacing the current mounted drives with the one defined in this file
services:
  svc-dev:
    build:
      args:
        << : *default-args
    volumes: # Relative paths doesn't work with WSL and docker for windows
      *default-volumes

  svc-test:
    build:
      args:
        << : *default-args
    volumes: # Relative paths doesn't work with WSL and docker for windows
      *default-volumes

  svc-codevalidation:
    build:
      args:
        << : *default-args
    environment:
      *default-env
```