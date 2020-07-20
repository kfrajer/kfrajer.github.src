---
author: "Cristian Mosquera"
title: "Git"
date: 2020-05-30T17:25:33-04:00
lastmod: 2020-05-30T17:25:33-04:00
description: "Summary of core Git commands for development"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- git
- git flow
- version control
- Cheatsheet
---

# Core Git commands

### Git init
* `git init`
* `git config --global user.name "username"`
* `git config --global user.email user@mail.com`
* `git config --global core.autocrlf true`
* `git config --global merge.tool meld`
* `git config --global mergetool.meld.cmd "meld \$LOCAL \$MERGED \$REMOTE --output \$MERGED"`
* Need to set git token to  pull/push using SSH strategy isntead of HTTP

### General 
* `git status`
* `git status -s`: Minimum output, s for short
* `git rev-parse --abbrev-ref HEAD`: Current branch name
* `git branch -a`: List all branches
* `git checkout {branch-name}`
* `git checkout -b {branch-name}`: create branch and switch into it

### Push and pull
* `git remote -v`
* `git remote rm {nameRemote}`
* `git remote add {nameRemote} {ssh:git_url}`
* `git fetch {branch-name}`: Bring changes but do not merge them
* `git add {fileName01} {fileName02} ... {fileName0N}`
* `git commit -m "Commit msg here"`
* `git push ` or ` git push --set-upstream {upstream-ref} {which-branch}`

### Reporting
* `git rev-parse --abbrev-ref HEAD`: Current branch name
* `git log --pretty=oneline`
* `git diff {branch1}..{branch2}`
* `git diff {fileName}`

### Stash
* `git stash`
* `git stash pop`
* `git stash list`
* `git stash show`: Show top files modified in the top stash
* `git stash show -p`: Shows actual file changes as a difference of to stash with current branch

### Amend
* `git commit --amend -m {new-commit-message}`
* `git commit -amend` ## Opens vi to edit commit msg. Type `a` for append. When done, press `ESC` then press `:` and type `wq` meaning write and exit
* `git cherry-pick {commitID01} {commitID02} ... {commitID0N}`
* `git rebase -i {commit-id-to-start-from}`: squash, fix commits, order commits, drop commits
* `git reset HEAD`: Reset unstaging changes (Reset "git add {...}")
* `git reset HEAD^`: Branch reset - reset last commit, move head to previous commit
* `git config --global alias.uncommit 'reset HEAD^'`: Use this as `git uncommit`
* `git reset HEAD {file}`: Unstage the file but maintain the modifications
* `git checkout -- {file}`: Revert a file back to the state it was in before any changes
* Rebasing commits from master into current branch
```bash
# master(public): c1 - c37
# feaure(mine): c1 - c2 - c3 - [...] - c36
git checkout {master-br-name}
git rebase {master-br-name} {feature-br-name}
# Final: c1 - c37 - c2 - c3 - [...] - c36
# Branch changed here would be the feature branch (aka current branch at the end is "feature" branch)  
# If conflict arises, rebase will stop and indicate where the conflict is (what file)
# - Resolve conflict using emacs:
# - Remove conflict indicators
# - Choose/amend changes to desired behavior
# - Save file and exit
# - `git rebase --continue`: It will continue rebase operation
```

### Housekeeping
* `git branch -D {branchName}`:  Removes branch even if it has not been pushed
* `git branch -m {oldName} {newName}`: Rename branch
* `git mv {oldFileName} {newFileName}`
* `GIT_TRACE_PERFORMANCE=1 git status`: To get a report in git ops and their performance

### Git submodule
* `git submodule add {URL-Repo}.git {folder}`
* `git submodule update --remote --merge`
* `git submodule update --init --recursive`