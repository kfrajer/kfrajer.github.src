---
author: "Cristian Mosquera"
title: "Git"
date: 2020-05-30T17:25:33-04:00
lastmod: 2020-05-30T17:25:33-04:00
description: ""
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- one
- two
---

# Core Git commands

* `git status`
* `git checkout`
* `git branch -a`: List all branches
* `git checkout -b`
* `git log --pretty=oneline`
* `git diff {branch1}..{branch2}`
* `git diff {fileName}`
* `git add {fileName01} {fileName02} ... {fileName0N}`
* `git commit -m "Commit msg here"`
* `git push `
* `git stash`
* `git stash pop`
* `git commit -amend` ## Type `a` for append. When changes are done, press `ESC` then press `:` and type `wq` meaning write and exit
* `git cherry-pick {commitID01} {commitID02} ... {commitID0N}`
* `git rebase -i {commit-id-to-start-from}`
* `git fetch master`: Bring changes but do not merge them
* [Rebasing commits from master in current branch]
* [Branch reset - unstaging changes]
* [Branch reset - dropping changes]

* `git branch -D {branchName}`:  Removes branch even if it has not been pushed
* `git branch -m {oldName} {newName}`: Rename branch
* `git mv {oldFileName} {newFileName}`

* `git submodule add {URL-Repo}`
* `git submodule update --remote --merge`
* `git submodule update --init --recursive`