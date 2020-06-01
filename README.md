# Wecome to kfrajer.github.src

## Overview

* Contains the source code for [https://kfrajer.github.io/](https://kfrajer.github.io/)

## Instructions
* Create a branch, makes changes and commit often
* A branch name needs to start with `feature/` or `bugfix/`
* Test changes locally by running local server: `hugo server` and then visit [http://localhost:1313](http://localhost:1313)
* When ready to deploy, execute `./cmd.sh`. This performs the following actions:
  - Push your current changes in your current branch to the **src** repository
  - Build your site to **published/** folder
  - Removes pesky CRLF introduce by Windows OS. TODO: Resolve this issue
  - Tag current branch based on automatic semantic versioning
  - Push changes to the `github.io` repo. Changes goes always against `master` branch
  - Sets your current branch in the **src** folder to `master`
  - Now you can visit [https://kfrajer.github.io](https://kfrajer.github.io) to explore the changes
* Manual step: Manage the pull request upstream. Merge the feature branch(FB) into master
* Manual step: Then, pull changes in your local `src` folder

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

## Handy References
* [Deploy personal pages in Github.IO](https://pages.github.com/)
* [Deploy using HUGO in Github pages](https://gohugo.io/hosting-and-deployment/hosting-on-github/)
* [Submodule handy guide](https://github.blog/2016-02-01-working-with-submodules/)

## Report bugs

Report any bugs in Github issue tracker [here](https://github.com/kfrajer/kfrajer.github.src/issues)

## License

* MIT
