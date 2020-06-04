#!/bin/bash

chmod +x crlf-cleanup.sh gh-deploy.sh ./.cicd.support/version.tracker.helper.sh
dos2unix gh-deploy.sh
dos2unix crlf-cleanup.sh
dos2univ ./.cicd.support/version.tracker.helper.sh

# $@ works for multiple arguments
# Always put it in double-quotes to avoid misparsing of arguments containing spaces or wildcards
# Note: $0 is not in $@
# Note: "$*" will be passed as one long string
./gh-deploy.sh "$@"
