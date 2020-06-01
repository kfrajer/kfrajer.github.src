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
