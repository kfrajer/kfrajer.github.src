---
author: "Cristian Mosquera"
title: "Dockerfile Multistage - Newsletter/PrintingPress (Go)"
date: 2020-05-30T18:09:54-04:00
lastmod: 2020-05-30T18:09:54-04:00
description: "Demo docker multi-stages"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- docker
- build
- Multistage
---

```
###############
#
FROM buildpack-deps:buster-curl as certGetter

## Copy from src to dest, load to base and outputed in master
ENV SRC_CERT=ORGANIZATION \
DEST_CERT=/usr/share/ca-certificates/ORGANIZATION \
BASE_CERT=/etc/ca-certificates.conf \
MASTER_CERT_FILE=/etc/ssl/certs

WORKDIR app/
COPY . .

RUN mkdir -p $DEST_CERT && cp -f $SRC_CERT/* $DEST_CERT/ && \
for i in `find ${SRC_CERT} -type f -name "*.crt"`; do echo $i >> $BASE_CERT; echo "Loading $i into $BASE_CERT"; done && \
echo "Calling update-ca-certificates..." && update-ca-certificates

ONBUILD RUN echo -e "\nFinish executing loading\n\nCertGetter\n\nNext step...\n"

###############
#
FROM buildpack-deps:buster-curl as printingPressGetter

ENV PRINTING_PRESS_VERSION="v0.2.0"
ENV PRINTINGPRESSFILE=printing-press_"${PRINTING_PRESS_VERSION}"_linux \
MASTER_PRINTINGPRESS=/usr/local/bin/printing-press

RUN curl -O https://artifactory.ORGANIZATION.org/generic/ORGANIZATIONSUB/printing-press/${PRINTINGPRESSFILE} && \
mv -v ./${PRINTINGPRESSFILE} $MASTER_PRINTINGPRESS && \
chmod +x $MASTER_PRINTINGPRESS

ONBUILD RUN echo -e "\nFinish executing loading\n\nPrintingPressGetter\n\nNext step...\n"

###############
#
FROM golang:1-alpine as buildStage

ENV APPROOT=$GOPATH/app

WORKDIR $APPROOT
#COPY Dockerfile Makefile go.* pkg scripts $APPROOT
COPY . $APPROOT

#RUN chmod +x scripts/report-gen-cmd.sh && make build
ENTRYPOINT ["scripts/report-gen-cmd.sh"]

    #ENTRYPOINT ["/bin/bash"]

    #CMD ["build"]
    #ENTRYPOINT ["make"]

ONBUILD RUN echo -e "\nFinish executing loading\n\nBuildStage:$APPROOT\n\nNext step...\n"

###############
#
FROM golang:1-alpine
#FROM alpine as runtime

ENV PATH=/usr/local/bin:/bin:/sbin:$PATH \
MASTER_PRINTINGPRESS=/usr/local/bin/printing-press \
MASTER_CERT_FILE=/etc/ssl/certs \
BINROOT=/app \
RECIPIENT_EMAIL="user@example.com" \
GITLAB_USER_EMAIL="user@example.com" \
SEND_EMAIL_FLAG=true
#OUTFOLDER="$BINROOT/publish" \


#RUN apk update && apk add --no-cache bash

WORKDIR /app
COPY . $BINROOT

COPY --from=certGetter $MASTER_CERT_FILE/* $MASTER_CERT_FILE/
COPY --from=printingPressGetter $MASTER_PRINTINGPRESS $MASTER_PRINTINGPRESS
COPY --from=buildStage /go/bin/newsletter-prep $BINROOT/newsletter-prep

##find . -type f -print0 | xargs -0 -n 1 -P 4 dos2unix
RUN for i in `find -type f -name "*.sh" -o -name "*.json"`; do sed -i 's/\r//g' $i; echo "Removing Windows end of line for : $i"; done && \
for i in `find editorial/ -type f -name "*.json"`; do sed -i ':a;N;$!ba;s/\n/ /g' $i; echo "Removing new line character03 in: $i"; done

#ENTRYPOINT ["/bin/bash"]
ENTRYPOINT "$BINROOT/newsletter-prep"
```
