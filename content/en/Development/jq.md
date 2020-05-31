---
author: "Cristian Mosquera"
title: "Jq"
date: 2020-05-30T18:00:31-04:00
lastmod: 2020-05-30T18:00:31-04:00
description: ""
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- one
- two
---

# Core JQ commands

Doc's main reference: [jq Tutorial](https://stedolan.github.io/jq/tutorial/)

## Commands in Docker context

* [TBD]

## Commands applied to log files

* `cat {filename} | jq '. | length'` : How many entries
* `cat {filename} | jq '. | {name: .appName}'` : Displays all appNames in each entry. They are each tagged with name
* `cat {filename} | jq '. | {LEVEL: .logLevel, MSG: .message, EXCEPTION: .exception}'` : Demo of multiple mapping
* `cat {filename} | jq '. | select(.exception != null) | {LEVEL: .logLevel, MSG: .message, EXCEPTION: .exception} '` : Selecting demo
* `cat {filename} | jq '. | select(.logLevel == "ERROR") | {MSG: .message} '` : Selecting demo