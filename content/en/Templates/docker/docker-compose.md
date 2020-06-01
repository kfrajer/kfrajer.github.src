---
author: "Cristian Mosquera"
title: "Docker Compose"
date: 2020-05-30T18:08:28-04:00
lastmod: 2020-05-30T18:08:28-04:00
description: "Core templates demonstrating docker-compose layouts"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- docker-compose
- docker
---

# Sample docker compose

```
version: '3'
services:
  web:
    build: .
    ports:
      - "5000:5000"
  redis:
    image: "redis:alpine"
```