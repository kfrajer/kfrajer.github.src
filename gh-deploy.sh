#!/bin/bash

## INSTRUCTIONS
## To run: `./gh-deploy.sh {folder} "{msg}"` 
## You might need to execute this first: `sed -i -e 's/\r$//' gh-deploy.sh`
## Parameters:
##   folder: Folder to output built pages
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

FOLDER2PUBLISH=../published
CURRENT_VERSION_TAG_TRACKER=".repo_version"
CURR_BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
MSG=""
CURRENT_SECONDS_EPOCH=$((`date +%s`))

if [ "$CURR_BRANCH_NAME" = master ]; then
    echo "ERROR: Your are in master. Deploy manually. Aborting..."
    exit 1;
fi

## Check no commits are pending in current branch
git_status=$(git status --porcelain)
if [ ! -z "$git_status" ]; then
    echo "ERROR: There are pending changes that need to be commited. Aborting..."
    echo "Debug: git_status returned: $git_status"
    exit 1;
fi

[ -n "$1" ] && FOLDER2PUBLISH="$1"
[ -n "$2" ] && MSG="$2"

calculate_new_tag_version "$CURRENT_VERSION_TAG_TRACKER" $CURR_BRANCH_NAME
TAG_VER=$new_version
[ -z "$MSG" ] && MSG="Rebuilding site $(date)\n\n* From $CURR_BRANCH_NAME : $TAG_VER"
update_version_tracking "$CURRENT_VERSION_TAG_TRACKER" "$TAG_VER" "$MSG"
git tag -a "$TAG_VER" -m "$MSG"


## NEXT is a temporal solution. To delete publish folder (rename and move to trash), then 
## pull from repo, only copy .git folder and remove other folders before re-building site
## Currently VSCode is locking in the publish folder so mv fails: CLOSE VSCode...bug2fix
## Alternate solution: To use submodule

#PREPARE folder to publish to site. Folder is populated by Hugo and this folder's 
#content is pushed to site repo

if [ -d "$FOLDER2PUBLISH" ]; then
    mkdir -p Trash    
    mv "$FOLDER2PUBLISH" Trash/deleted."$FOLDER2PUBLISH"."$CURRENT_SECONDS_EPOCH"
fi
git clone git@github.com:kfrajer/kfrajer.github.io.git "$FOLDER2PUBLISH"/tmpFolder
mv "$FOLDER2PUBLISH"/tmpFolder/.git "$FOLDER2PUBLISH"
mv "$FOLDER2PUBLISH"/tmpFolder Trash/"$FOLDER2PUBLISH"/tmpFolder."$CURRENT_SECONDS_EPOCH"

# Generate the content using Hugo
hugo -d $FOLDER2PUBLISH

## Clean up end-of-lines CR/LF chars
source ./.cicd.support/crlf-cleanup.sh ".sh" ".md" ".html" ".htm" ".css" ".js" ".xml" ".json" ".txt" 

git push --set-upstream origin $CURR_BRANCH_NAME --follow-tags

## Copy site readme file to folder
cp -f README.site.md $FOLDER2PUBLISH/README.md
# Instruct Github this static content is not using jekyll
[ ! -f "$FOLDER2PUBLISH/.nojekyll"  ] && touch "$FOLDER2PUBLISH/.nojekyll"

# Go To Public folder
cd $FOLDER2PUBLISH

# Add changes to git, commit and pushed built site to github.io repo
git add .
git commit -m "$MSG"
git tag -a "$TAG_VER" -m "$MSG"
git push origin master --follow-tags

# Revert to previous directory
cd -

# Set current branch to master
git checkout master

# Rename current branch as done
git branch -m "$CURR_BRANCH_NAME" "DONE-$CURR_BRANCH_NAME"

set +x

printf "\033[0;32m ....................................... \033[0m\n"
printf "\033[0;32mDeploying updates to GitHub...\033[0;33mDONE\033[0m\n"
printf "\033[0;32m ....................................... \033[0m\n\n"

printf "\033[0;33mDon't forget: \033[0;32mYou need to now create a pull request upstream. Branch:\033[0;33m %s \033[0m\n" "$CURR_BRANCH_NAME"
printf "Visit 'https://github.com/kfrajer/kfrajer.github.io' and merge recent uploaded branch into master\n"
printf "'git checkout master && git pull': After merge to update local repo\n"
printf "\n'git submodule update --init --recursive': Aligns base repo with latest submodule changes\n\n"

printf "\033[0;32mYour current branch is now set to \033[0;33m \"master\" \033[0m\n"
