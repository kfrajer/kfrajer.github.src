---
author: "Cristian Mosquera"
title: "Python Virtualenv"
date: 2020-05-30T18:00:56-04:00
lastmod: 2020-05-30T18:00:56-04:00
description: ""
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- one
- two
---

# Python Virtual Environment

## For Linux
* `virtualenv -v venv --python=/usr/bin/python3`
* `source ./venv/bin/activate`

## For Windows

* `python -m pip install --proxy=http://u:p@proxy-svc-name.com:port --upgrade pip`
* `pip install --proxy=http://u:p@proxy-svc-name.com:port virtualenv`
* `virtualenv -v {envName} --python=c:\Python37\python.exe`
* `{envName}\Scripts\activate`
[…]
* `deactivate`
* `doskey /history`