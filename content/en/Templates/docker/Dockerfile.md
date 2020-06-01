---
author: "Cristian Mosquera"
title: "Dockerfile sample"
date: 2020-05-30T18:08:14-04:00
lastmod: 2020-05-30T18:08:14-04:00
description: "Demo dockerfile using GOlang as base image
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- docker
- build
---

# Instructions

* docker build -t {imageName} .
* docker run -it --rm --mount type=bind,src=/c/Users/C/workspace/out,dst=/app/publish --name {containerName} {imageName} 

_______

# Dockerfile content

```
FROM golang:1.14

ENV \
PRINTING_PRESS_VERSION="v0.2.0" \
APPROOT="/app" \
OUTFOLDER="$APPROOT/publish" \
RECIPIENT_EMAIL="user@example.com" \
GITLAB_USER_EMAIL="user@example.com" \
SEND_EMAIL_FLAG=true

WORKDIR $APPROOT
COPY . $APPROOT

##find . -type f -print0 | xargs -0 -n 1 -P 4 dos2unix
RUN for i in `find -type f -name "*.sh" -o -name "*.json"`; do sed -i 's/\r//g' $i; echo "Removing Windows end of line for : $i"; done
##RUN for i in `find editorial/ -type f -name "*.json"`; do sed -i ':a;N;$!ba;s/\n/ /g' $i; echo "Removing new line character03 in: $i"; done

RUN \
chmod +x scripts/get-template-generator.sh \
chmod +x scripts/report-gen-cmd.sh && \
chmod +x scripts/set-ORGANIZATION-certificates.sh && \
scripts/set-ORGANIZATION-certificates.sh && \
scripts/get-template-generator.sh

ENTRYPOINT ["scripts/report-gen-cmd.sh"]
```