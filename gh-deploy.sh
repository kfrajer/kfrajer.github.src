#!/bin/bash

## INSTRUCTIONS
## To run: `./gh-deploy.sh {folder} "{msg}"` 
## You might need to execute this first: `sed -i -e 's/\r$//' gh-deploy.sh`
## Parameters:
##   folder: Folder to output built pages. Default is published
##   msg: Message to add to commit. Use quotes if msg has any spaces
##

# ###########################################################################
#
#                                    XXXXX
#
# ###########################################################################

# If a command fails then the deploy stops
set -e
set -x

source ./.cicd.support/version.tracker.helper.sh

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

FOLDER2PUBLISH=published
MSG="Rebuilding site $(date)"
VERSION_FILE_TRACKER=".repo_version"
branchName=$(git rev-parse --abbrev-ref HEAD)

if [ "$branchName" = master ]; then
    echo "ERROR: Your are in master. Deploy manually. Aborting..."
    exit 1;
fi

[ -n "$1" ] && FOLDER2PUBLISH="$1"
[ -n "$2" ] && MSG="$2"

# Build the project.
hugo -d $FOLDER2PUBLISH

calculate_new_tag_version "$VERSION_FILE_TRACKER" $branchName
get_tag_version "$VERSION_FILE_TRACKER"
TAG_VER=$read_version
update_version_tracking "$TAG_VER" "$MSG"

if [ -n "$TAG_VER" ]; then
    git tag -a "$TAG_VER" -m "$MSG"
fi

## Clean up CRLF end of line chars
./crlf-cleanup.sh

git push --set-upstream origin $branchName

# Go To Public folder
cd $FOLDER2PUBLISH

## Copy site readme file to folder
cp -f ../README.site.md README.md
# Instruct Github this static content is not using jekyll
[ ! -f ".nojekyll"  ] && touch .nojekyll

# Add changes to git, commit and pushed built site to github.io repo
git add .
git commit -m "$MSG"
git push origin master --follow-tags

# Revert to initial directory
cd ..

git checkout master

set +x

printf "\033[0;32m ....................................... \033[0m\n"
printf "\033[0;32mDeploying updates to GitHub...\033[0;33mDONE\033[0m\n"
printf "\033[0;32m ....................................... \033[0m\n\n"

printf "\033[0;33mDon't forget: \033[0;32mYou need to now create a pull request upstream. Branch:\033[0;33m %s \033[0m\n" "$branchName"
printf "Visit `https://github.com/kfrajer/kfrajer.github.io` and merge recent uploaded branch into master\n"
printf "`git checout master && git pull`: After merge to update local repo\n"
printf "\n`git submodule update --init --recursive`: Aligns base repo with latest submodule changes\n\n"

printf "\033[0;32mYour current branch is now set to \033[0;33m \"master\" \033[0m\n"
