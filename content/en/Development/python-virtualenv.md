---
author: "Cristian Mosquera"
title: "Python Virtualenv"
date: 2020-05-30T18:00:56-04:00
lastmod: 2020-05-30T18:00:56-04:00
description: "Python virtual environment best practices"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- Python
- virtualenv
---

## Python Virtual Environment

### Install

#### Linux
* `python -m pip install --proxy=http://u:p@proxy-svc-name.com:port --upgrade pip`
* `pip install --proxy=http://u:p@proxy-svc-name.com:port virtualenv`

#### Windows
To set the python virtualenv in Windows see https://mothergeo-py.readthedocs.io/en/latest/development/how-to/venv-win.html

### Additional reference from Google GAE
1. https://cloud.google.com/python/setup
2. https://cloud.google.com/appengine/docs/flexible/python/quickstart


### Start environment
* For Linux, run the following script to activate the environment using local Python3
```bash
PY3PATH=$(which python3)
ENVNAME=wslenv
virtualenv --python="$PY3PATH" $ENVNAME
source "./$ENVNAME/bin/activate"
```

* For Windows
```bash
virtualenv --python C:\Python37\python.exe {env_name}
.\{env_name}\Scripts\activate
```

### Stop environment
Just type: `deactivate`









