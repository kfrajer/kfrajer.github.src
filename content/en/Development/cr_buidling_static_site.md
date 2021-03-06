---
author: "Cristian Mosquera"
title: "Building a Hugo Page"
date: 2020-05-30T17:29:59-04:00
lastmod: 2020-05-30T17:29:59-04:00
description: "Steps to create this site"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- Hugo
- static-generator
- web
- Golang
---

------------------------------------------------------------------------
Building a Site: Generation
*) (Why to setup a static site?)[#]
*) Install HUGO (Binary+add to PATH)
*) (Preparing emacs HUGO mode)[#]
*) (First Site: Design Layout)[#]
*) (Git setup)[#, Ref]
*) Theme selection
*) First post!
*) (Emal setup as a web service)[#]

------------------------------------------------------------------------
Building a Site: Deployment

*) Brand name selection: namechk.com
*) Web hosting services: GitHub, https://www.nearlyfreespeech.net/, atspace.cc, AWS, Heroku, Digital Ocean (VPS)


------------------------------------------------------------------------
Web hosting services
Setting up page hosting using (GitHub)[https://gohugo.io/hosting-and-deployment/hosting-on-github/].
You will need to decide if you are hosting a page specifically for a project or for a user/organization sie. I am choosing the later.
The steps to follow are:
*) Go to github and register using a valid account
*) Name repo kfrajer.github.io

------------------------------------------------------------------------
Business Consideration
*) Branding and logo
*) Copyright
*) Business cards

------------------------------------------------------------------------
Why to setup a static site?
Hugo
Jekyll (MUO)
GitHub
vs. WordPress (MUO, Traversy Media)

------------------------------------------------------------------------
First Site: Design Layout
*) Experience and Personal Interests
*) Projects
*) Blog posts
*) Code Recipes
*) Reference links
*) About
*) Contact

------------------------------------------------------------------------
Understanding Licenses
GPL
MIT


------------------------------------------------------------------------
HUGO setup details
*) cd C:/mySandBox/DockerSpace/Hugo/kfrajer-hugo/
o) vist `https://github.com/gohugoio/hugo/releases/` and select version for ubuntu/debian, download it.
o) sudo apt install /c/Users/C/Downloads/hugo_0.71.1_Linux-64bit.deb
o) hugo version  ## v0.71.1
*) mkdir kfrajer.github.io
*) hugo new site .
*) git init
*) git config --global user.name "kfrajer"
*) git config --global user.email krisfrajer@gmail.com
*) git config --global core.autocrlf true
*) git config --global merge.tool meld
*) git config --global mergetool.meld.cmd "meld \$LOCAL \$MERGED \$REMOTE --output \$MERGED"
*) git submodule add https://github.com/zzossig/hugo-theme-zzo.git themes/zzo
*) ALSO WHEN NEEDED: `git submodule update --remote --merge`
*) Follow quick start for this theme 
*) First: Check example site works:
  -) cd themes/zzo/exampleSite
  -) hugo server
*) Then copy config, content, rsources and static to root
  -) `hugo new <SECTIONNAME>/<FILENAME>.<FORMAT>` to add new content  
    *) other themes of interest:
      -) Intro to themes: https://www.youtube.com/watch?v=hBQlCtfRmqs&list=PL-Kz5P-mYdMgAJDmRJquyMHfdaIOD-3oj&index=4
      -) DOCS:
      -) https://themes.gohugo.io/hugo-theme-techdoc/
      -) https://themes.gohugo.io/ace-documentation/
      -) https://themes.gohugo.io/hugo-theme-zdoc/   ***
      -) https://themes.gohugo.io/hugo-theme-zzo/    ***
      -) https://themes.gohugo.io/beautifulhugo/
      -) https://themes.gohugo.io/hugo-theme-prav/
      -) PROFILE
      -) https://themes.gohugo.io/hugo-devresume-theme/
      -) https://themes.gohugo.io/hugo-orbit-theme/
      -) SHOWCASE
      -) https://themes.gohugo.io/hugo-theme-bootstrap4-blog/
      -) https://themes.gohugo.io/hugo-book/
      -) https://themes.gohugo.io/hugo-cards/
      -) https://themes.gohugo.io/strange-case/
      -) https://themes.gohugo.io/binario/
      -) https://themes.gohugo.io/midnight/
      -) https://themes.gohugo.io/hugo-primer/
      -) OTHERS
      -) Alabaster, Hugof, SP Minimal
      -) Hyde Hyde, After Dark, Main Road
      -) Blog ==> Geppaku, Twenty Fourteen 
      -) CV==> Academic, Agency
      -) Titles==> Hestia Pure, Nederburg, Tracks, Hugo Future Imperfect, Robust
      -) Hugo Bootstrap V4, Kraiklyn, Blackburn
      -) Code Editor, Wave, Hyde, Docu API, Strange Case, Liquorice, Theme Hugo Foundation6
  -) Load via `hugo server`
  -) https://gohugo.io/ for quickstart guide and docs 
x) Note that config.toml file has this line `theme = "zzo"` 
#) hugo new post/welcome.md   <===https://www.youtube.com/watch?v=w7Ft2ymGmfc
+) echo " #Wecome to kfrajer.github.src" >> README.md
+) git add .
+) git commit -m "Hugo base template init"
+) git remote add origin https://github.com/kfrajer/kfrajer.github.src.git
+) git push -u origin master
o) hugo new Development/git.md
hugo new Development/docker.md
o) Modified content/index.md    <=== FROM https://github.com/digitalcraftsman/hugo-alabaster-theme/tree/master/exampleSite/content
o) Modified content/post/welcome.md
o) git add . 
o) git commit -m "Added my first few posts: index in content, welcome in content/post. Added homepage tag and remove draft parameter on md header"
o) hugo serve -w   <=== WORKS!
o) hugo -d published   <===  builds html/css/js to deploy
o) Create .gitignore and add the folder above: `published/**`
TEST: http://localhost:1313
TEST: http://localhost:1313/post/welcome/
o) git push -u origin master

------
x) git fetch origin
x) git status
*) hugo new <SECTIONNAME>\<FILENAME>.<FORMAT>
*) hugo serve


