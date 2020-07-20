---
author: "Cristian Mosquera"
title: "Setup Docker in Wsl"
date: 2020-05-30T19:50:05-04:00
lastmod: 2020-05-30T19:50:05-04:00
description: "Installing Docker in Windows Subsystem Linux"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- Docker
- WSL
- Cheatsheet
---

## Installing Docker in Windows Subsystem Linux (WSL)

### NOTES
- After ssummer 2020, you need to have WSL2 which is made available for Windows 10 Home edition
- It is recommended to upgrade to Windows 10 Pro
- In "Turn Windows features on and off", check "Windows Hypervisor Platform"
- To be confirmed, check "Hyper-V"? Currently working but this is not checked. To investigate...
- Finally, install "Docker Destop" and ensure the `docker-machine` is up and running. Enable WSL2 support and add the following line in your Linux distro: `export DOCKER_HOST=unix:///var/run/docker.sock`

### Instructions

```bash
$ sudo apt install apt-transport-https ca-certificates curl software-properties-common
$ sudo apt-get remove docker docker-engine docker.io containerd runc

$ sudo apt-get update

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
$ sudo apt-get update
$ apt-cache policy docker-ce
$ sudo apt install docker-ce

$ apt list -a docker-ce
$ echo $USER
$ sudo usermod -aG docker $USER

Log out and back in [OR] `su - ${USER}`

$ id -nG  ## You should be in the docker group
$ sudo usermod -aG docker username  ## Optional


$ sudo nano /usr/local/sbin/start_docker.sh

  > #!/usr/bin/env bash
  > sudo cgroupfs-mount
  > sudo service docker start


$ sudo chmod +x /usr/local/sbin/start_docker.sh
$ sudo chmod 755 /usr/local/sbin/start_docker.sh
$ sudo nano /etc/sudoers
  > {your username here} ALL=(ALL:ALL) NOPASSWD: /bin/sh /usr/local/sbin/start_docker.sh  ## User echo $USER for username
$ /bin/sh /usr/local/sbin/start_docker.sh



$ `sudo systemctl status docker` [OR] `sudo service docker status`
```

### REFERENCES

* [INTRO to Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04)
* [Docker Running Seamlessly in Windows Subsystem Linux](https://medium.com/faun/docker-running-seamlessly-in-windows-subsystem-linux-6ef8412377aa)
