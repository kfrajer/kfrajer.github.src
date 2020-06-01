#!/bin/bash


chmod +x crlf-cleanup.sh gh-deploy.sh
dos2unix gh-deploy.sh
./gh-deploy.sh 
