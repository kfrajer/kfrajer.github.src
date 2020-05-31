---
author: "Cristian Mosquera"
title: "Docker Knowlegde Base"
date: 2020-05-30T17:29:59-04:00
lastmod: 2020-05-30T17:29:59-04:00
description: "Core Docker commands for development in Linux"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- Docker
- Docker-compose
- Linux
- WSL
- Cheatsheet
---

# Core Docker commands

* `docker ps -a`
* `docker run --rm --name {containerName} {imageName}`
* `docker run --rm -it --name {containerName} {imageName}`
* `docker logs -f {containerName}`: Continuos logs
* `docker exec -it {containerName} {cmd-to-execute}`
* `alias ccx='f(){ [ -n "$1" ] && docker exec -it "$1" /bin/bash; unset -f f; };` : Creates bash session in running container
* `docker inspect {containerName}`

* Yellow='\033[0;33m
* IRed='\033[0;91m'
* IBlue='\033[0;94m'
* NC='\033[0m'
* `echo -e "$(docker ps --format "${Yellow}{{.Names}}${NC}\n\tStatus:${IRed} {{.Status}}${NC}\n\t${IBlue}Container ID:${NC} {{.ID}}\t${IBlue}Command:${NC} {{.Command}}\n\t${IBlue}Image:${NC} {{.Image}}" )"`
* `VVBODY="$(docker ps -a --format "${IRed}{{.Status}}${NC},${Yellow}{{.Names}}${NC} , {{.ID}} , {{.CreatedAt}}" )"; echo -e "$VVBODY" | column -t -s,`
* `echo -e "$(docker ps -a --format "${Yellow}{{.Names}}${NC}\n\tStatus:${IRed} {{.Status}}${NC}\n\t${IBlue}Container ID:${NC} {{.ID}}\t${IBlue}Command:${NC} {{.Command}}\n\t${IBlue}Image:${NC} {{.Image}}\n\t${IBlue}CreatedAt:${NC} {{.CreatedAt}}" )"`
* `VVHEAD="${Black}${On_White}\tSTATUS,CONTAINER-ID,CMD,IMAGE,CREATED AT${NC}";VVBODY="$(docker ps -a --format "${Yellow}{{.Names}}${NC}\n\t${IRed}{{.Status}}${NC} , {{.ID}} , {{.Command}} , {{.Image}} , {{.CreatedAt}}" )";echo -e "$VVHEAD\n$VVBODY" | column -t -s,`

* `docker build -t {imageTag} .`
* `docker build -t {imageTag} -f {DockerfileName} .` : Context set to current folder
* `docker run -it --rm --mount type=bind,src=/c/Users/USR/Documents/folder,dst=/app/publish --name {appName} {imagetag}`

* `docker rm $(docker ps -a -q)`
* `[ -n "$(docker ps -a -q)" ] && echo "Removing idle containers" && docker rm $(docker ps -q -f "status=exited")`
* `docker rmi $(docker images | awk '{print $3}')`
* `docker rmi $(docker images | grep "<none>" | awk '{print $3}')`
* `docker images prune`
* `docker images ls`
* `docker volumes prune`
* `docker volumes ls`

* `docker network ls`
* `docker network rm {name}`

# Core docker-compose commands
* `docker-compose up --build`
* `docker-compose --verbose up --build -d`
* `docker-compose down`
* `docker-compose -f file01.yml -f file02.yml up`
* `docker-compose run {serviceName}`
* `docker-compose stop   && docker-compose rm -f ""`: Removes only the containers. It doe snot remove volumes or network adapters
* `f(){ docker-compose stop "$@"  && docker-compose rm -f "$@"; unset -f f; }; f` : To be used in a bash function

## Other commands
* `export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0`
* `export DOCKER_HOST='tcp://localhost:2375'`
* `export DOCKER_HOST=unix:///var/run/docker.sock`