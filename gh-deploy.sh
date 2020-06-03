#!/bin/bash

## INSTRUCTIONS
## To run: `./gh-deploy.sh {folder} "{msg}"` 
## You might need to execute this first: `sed -i -e 's/\r$//' gh-deploy.sh`
## Parameters:
##   folder: Folder to output built pages. Default is published
##   msg: Message to add to commit. Use quotes if msg has any spaces
##

# If a command fails then the deploy stops
set -e
set -x

#Reads the version stored in the version file.
#All lines that starts with '#' are ignored. reads first non-commented line
#  REQUIRES: Version file to exist
#  INPUT: File name storing current version
#  RETURN: Version found in file
function get_tag_version {
    TAG_FILE="$1"
    if [ ! -f "$TAG_FILE" ]; then
        echo "ERROR: File $TAG_FILE does not exist. Aborting..."
        exit 1;
    fi

    # First non-commented line
    first_line="$(grep -m 1 -v -e "#" $TAG_FILE)"
    read_version=$first_line
    return 0
}

#Calculates a new version based on branch name
#Branch name needs to start with either mayor/feature/features/bugfix/bugfixes followed by a description
#Example: feature/added-unittest
#  REQUIRES: Version file to exist
#  INPUT: File name storing current version
#  INPUT: branchName: current branch name to process
#  OUTPUT: new_version contains the new calculated version
#  RETURN: 0 if success, non-zero otherwise
function calculate_new_tag_version {
    TAG_FILE="$1"
    curr_branch_name="$2"

    get_tag_version "$TAG_FILE"
    prev_version=$read_version
    # Remove v in vX.X.X
    last_version00=$(echo $prev_version | sed 's/v//' )
    # Remove leading/trailing white spaces
    last_version=$(echo $last_version00 | sed 's/ *$//g')
    #Tokenize
    OLDIFS=$IFS
    IFS='.'; only_version=( $last_version ); 
    IFS=$OLDIFS
 
    MAYOR=${only_version[0]}
    MINOR=${only_version[1]}
    PATCH=${only_version[2]}
    echo "Version is >$MAYOR< : >$MINOR< : >$PATCH<"    

    if [[ $curr_branch_name == mayor/* ]]; then
        MAYOR=$((MAYOR+1))
    elif [[ $curr_branch_name == feature/* ]] || [[ $curr_branch_name == features/* ]]; then
        MINOR=$((MINOR+1))
    elif [[ $curr_branch_name == bugfix/* ]] || [[ $curr_branch_name == bugfixes/* ]]; then
        PATCH=$((PATCH+1))
    else
        echo "ERROR: Branch name \"$curr_branch_name\" not recognize. It need to start with \"mayor/\", \"feature/\" or \"bugfix/\". Aborting..."
        exit 1;
    fi

    new_version="v$MAYOR.$MINOR.$PATCH"

    #Report
    echo "REPORT: File \"$TAG_FILE\" updated from $prev_version to $new_version"

    return 0;
}

#Updates file tracking versioning
#Currently it manages three file. Main file contains only the current version, 
#.old contains list of versions and .history contains version+date+message history
#  INPUT: New version being generated
#  INPUT: Message
#  OUTPUT: 3 version tracking files are updated
#  RETURN: 0 if success, non-zero otherwise
function update_version_tracking {
    if [ -z "$1" ]; then
        echo "ERROR: You need to provide the new version to update history and internal version tracker. Aborting..."
        exit 1;
    fi
    new_version=$1
    msg="Rebuilding site $(date)"
    [ -n "$2" ] && msg="$2"
    curr_date="$(date)"

    # Append new version to file tracker of published versions
    echo "$new_version"  >> $TAG_FILE.old
    # Append version and message to history to upload to static site
    # TODO: Either soft-link to internal post or update actual post (.md) content
    # TODO: Evaluate if vers calculation should be done before building site (git push in src. vs. site.io)
    # TODO: Setup .history new lines as markup table
    echo "* $new_version : $cur_date : $msg"  >> $TAG_FILE.history
    # Re-create the $TAG_FILEn file
    echo "# Do not edit this file" > $TAG_FILE
    echo "# Semantic versioning: v{MAYOR}.{MINOR}.{PATCH}" >> $TAG_FILE
    echo "$new_version" >> $TAG_FILE
    return 0;
}

# ###########################################################################
#
#                                    XXXXX
#
# ###########################################################################

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
