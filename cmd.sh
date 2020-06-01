#!/bin/bash

chmod +x crlf-cleanup.sh gh-deploy.sh
dos2unix gh-deploy.sh

# $@ works for multiple arguments
# Always put it in double-quotes to avoid misparsing of arguments containing spaces or wildcards
# Note: $0 is not in $@
# Note: "$*" will be passed as one long string
./gh-deploy.sh "$@"
