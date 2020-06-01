 # Wecome to kfrajer.github.io

## Overview

## Instructions

### Current submodules
* .src repo (https://github.com/kfrajer/kfrajer.github.src) has one submodule setup:
* Hugo theme: ZZO
* [UNDER revision] A second one for the repo hosting the site: https://github.com/kfrajer/kfrajer.github.io
  - If implemented, at the end when returning to root dir, need to update submodule for every deploy
* Reference: https://gohugo.io/hosting-and-deployment/hosting-on-github/
* To update any changes/commit in the submodule to be reflected in the main/master repo, run:
  `git submodule update --init --recursive`

### Semantic versioning
* Semantic vesrioning track in .repo_version file (See below)
* Any branch name should start with either "mayor/"; "feature/" or "features/"; or "bugfix/" or "bugfixes/". 
* When pushing, a new tag is created taking the current version and increasing the respective field: mayor, minor or patch matching if it is a mayor, feature or bug fix

### .repo_version
* Do not tempered with the .repo_version file
* If .repo_version is deleted by accident, create one with the latest tag version as found in the published repo. Version is first non-commented line. Example: "v0.1.0" with no quotes. Any line that starts with '#' are treated as comments

## Report bugs

## License
