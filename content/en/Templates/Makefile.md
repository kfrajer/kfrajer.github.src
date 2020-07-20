---
author: "Cristian Mosquera"
title: "Makefile"
date: 2020-05-30T18:10:09-04:00
lastmod: 2020-05-30T18:10:09-04:00
description: "Makefile demo - Nesletter project"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- c++
- make
- Makefile
---

### Makefile: Newsletter/Printing Press Template (Go)

```makefile  {linenos=true}
.DEFAULT_GOAL := build
.PHONY: clean


CTIMESTAMP=$(shell date +%Y%m%d%H%M%S)

MAIN=newsletter-prep

DF_ORIGINAL=dockerfiles/df-original/Dockerfile
DF_STAGES=dockerfiles/df-stages/Dockerfile
DC_DF_FILE=dockerfiles/dockercompose/Dockerfile
DC_MAIN_FILE=dockerfiles/dockercompose/docker-compose.yml

LOGFILE=log-backups.log
TRASH=Trash/

info:
        @ echo "Build and runs report generator (code name newsletter"

safebackup: clean
        $(shell echo ":::::Dockerfile_$(CTIMESTAMP)" >> $(TRASH)/$(LOGFILE))
        @echo ":::::Dockerfile_$CTIMESTAMP"
        -@test -f Dockerfile && $(shell head -n 3 Dockerfile >> $(TRASH)/$(LOGFILE))
        -@test -f Dockerfile && $(shell [ ! -s Dockerfile ] && echo "       (Dockerfile was empty)" >> $(TRASH)/$(LOGFILE))
        -@test -f Dockerfile && cp -vf Dockerfile $(TRASH)/Dockerfile_$(CTIMESTAMP) || true
        -@test -f docker-compose.yml && cp -vf docker-compose.yml $(TRASH)/docker-compose_$(CTIMESTAMP).yml || true

safeori: safebackup
        -@test -f Dockerfile && mv Dockerfile $(DF_ORIGINAL)

safestages: safebackup
        -@test -f Dockerfile && mv Dockerfile $(DF_STAGES)

safedc: safebackup
        -@test -f Dockerfile && mv Dockerfile $(DC_DF_FILE)
        -@test -f docker-compose.yml && mv docker-compose.yml $(DC_MAIN_FILE)

checkifsafe:
        -@test -f Dockerfile && echo "!!!!! WARNING: Dockerfile exist." && echo "!!!!! WARNING: You need to save proper session first"

ori: checkifsafe
        -@test ! -f Dockerfile && cp $(DF_ORIGINAL) .

stages: checkifsafe
        -@test ! -f Dockerfile && cp $(DF_STAGES) .
dc: checkifsafe
        -@test ! -f Dockerfile && cp $(DC_DF_FILE) .
        -@test ! -f docker-compose.yml && cp $(DC_MAIN_FILE) .

build: clean
        CGO_ENABLED=0; GOOS=linux GOARCH=amd64 go build -ldflags '-s -w' -v -o ./pkg/...
        chmod +x $(MAIN)

## STATICALLY compiled binary: RUN CGO_ENABLED=0 go get -a -ldflags '-s' github.com/adriaandejonge/helloworld

run: build
        ./$(MAIN)

tar:
        tar -cvf ~/backup_$(CTIMESTAMP).tar *
        echo "Backup created at ~/backup_$(CTIMESTAMP).tar"
clean:
        @ echo "Cleaning up..."
        mkdir -p $(TRASH)
        mv -f $(MAIN) $(TRASH) || true
        FILES="$(shell find -type f -name '*.*~' -o -name '*~')"; mv -f $$FILES $(TRASH) || true
        @ echo "Cleaning up... DONE"

test:
        @echo "CTIMESTAMP is $(CTIMESTAMP)"
        -@test -f Dockerfile && echo "File does exist"
        -@test ! -f Dockerfile && echo "File does NOT exist $CTIMESTAMP"
```

### Makefile: Bets Containeration (NodeJS)

```makefile  {linenos=false}
.DEFAULT_GOAL := restart

CTIMESTAMP=$(shell date +%Y%m%d%H%M%S)

up: ## Spin al lservices up
        @ echo "Spinning containers up!"
        docker-compose up --build -d
        # ccps

down: ## Spin all services down and remove all associated volumes
        @ echo "Tearing down, wait...!"
        docker-compose down -v
        #docker volume rm webapp-data webapp-logs

delay:
        sleep 5

run: restart ## Alias for restart goal

restart: down delay up info ## Spins the services down and then up (Default goal)

info2: ## Attempt to print pretty `docker ps`
        @echo  "$(docker ps --format "${Yellow}{{.Names}}${NC}\n\tStatus:${IRed} {{.Status}}${NC}\n\t${IBlue}Container ID:${NC} {{.ID}}\t${IBlue}Command:${NC} {{.Command}}\n\t${IBlue}Image:${NC} {{.Image}}" )"

info: ## To run when service is up. Prints each service logs, current network and output each container's ip addr
        @echo "CTIMESTAMP is $(CTIMESTAMP)"
        docker logs mysql
        @echo "======="
        docker logs cronjob
        @echo "======="
        docker logs webapp
        @echo "======="
        docker network ls
        @echo "======="
        docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql
        docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' webapp
        docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cronjob
        cat /etc/resolv.conf

test: ## Test the webapp service
        @echo "Testing services..."
        curl "http://localhost:8080/status"
        #@echo "======="
        #curl "http://webapp:8080/status"
        @echo "END of TEST"

.PHONY: man
man: help ## Alias for help goal

.PHONY: help
help: ## This help
        @ echo "=========="
        @ echo "Help menu:"
        @ echo "=========="
        @ echo "INSTRUCTIONS: Type 'make {GOAL}' where {GOAL} is any of the following entries:"
        @ echo ""
        @grep -hE '^[a-zA-Z_-]+.*?:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: ## Remove temporal/backup file screated by editors
        @ echo "Cleaning up…"
        mkdir -p $(TRASH)
        mv -f $(MAIN) $(TRASH) || true
        FILES="$(shell find -type f -name '*.*~' -o -name '*~')"; mv -f $$FILES $(TRASH) || true
        @ echo “Cleaning up… DONE
```
