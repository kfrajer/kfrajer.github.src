#!/bin/bash

chmod +x ./.cicd.support/crlf-cleanup.sh gh-deploy.sh ./.cicd.support/version.tracker.helper.sh
dos2unix gh-deploy.sh
dos2unix ./.cicd.support/crlf-cleanup.sh
dos2unix ./.cicd.support/version.tracker.helper.sh

# $@ works for multiple arguments
# Always put it in double-quotes to avoid misparsing of arguments containing spaces or wildcards
# Note: $0 is not in $@
# Note: "$*" will be passed as one long string
./gh-deploy.sh "$@"
