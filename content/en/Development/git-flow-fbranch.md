---
author: "Cristian Mosquera"
title: "Git Flow - Feature branch"
date: 2020-05-30T18:11:04-04:00
lastmod: 2020-05-30T18:11:04-04:00
description: "Git flow using feature branch strategy"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- Git
- Cheatsheet
- Git flow
- version control
---

# Git flow

* Set git for the first time:
    - E-mail, name, crlf line termination handling
    - git init
    - git config --global user.name "kfrajer"
    - git config --global user.email krisfrajer@gmail.com
    - git config --global core.autocrlf true
    - git config --global merge.tool meld
    - git config --global mergetool.meld.cmd "meld \$LOCAL \$MERGED \$REMOTE --output \$MERGED"
    - Set git token
* git clone repo(s) locally
* Create a branch with named either feature(s)/{feature-name}, bugfix/{issue-name} or mayor/{name}
    - git checkout -b {purpose}/{name}
* Perform changes, add unit/system/integration tests
* Commit often
* Push upstream to origin. For a branch not in origin yet, you need to push providing the branch name:
    - git push --set-upstream origin your_branch_name
    - If CI exist, this operation should trigger running all tests
    - This push can be done multiple times as long as the branch is not merged against master
* Any additional/new code and commits can be pushed to this branch while in wip
* When the feature is ready, or to start an early review, create a merge request (MR)
    - Any additional commit will automatically update your MR
    - You can start MR anytime even if feature is not yet done.
    - Add the WIP(work in progress) header so the branch is not merged by accident in the case that is not ready to be merged
    - Add a one line header starting with either [FEATURE] or [BUGFIX] follow by a short descriptive title, an empty line and a body describing details of the MR. It is useful to have a template.
    - Tick delete branch and squash commit (in case of multiple commits)
    - Address and resolve all threads from the multiple discussions from the reviewers
    - For any code corrections, additions or deletions, perform them locally, commit and push them upstream to this branch
* Merge your feature/bug fix after approval is granted.
    - If squash commits is needed and was enabled, you need to update the "squash commits" commit message
    - This will trigger running the CI on the master with the new changes.
    - Only merge after configuration changes are done (in case they are needed for this MR)
* After a successful merge, master is tagged with semantic versioning.
* Deploy master
    - Deploy into dev environment
    - Perform sanity test (advanced integration test)
* Deploy to other environments (User aceptance testing, QA, prod)

## To be discussed
* Resolving merge conflicts
* Pull rebasing before pushing upstream