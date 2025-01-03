---
title: "Disinformation Dictionary"
format: html
execute: 
  enabled: false
---

You can contribute to the Desinformation Dictionary in multiple ways

- low tech approach: just modify a chapter file or write a new one
- Rstudio: render Dictionary on your PC and preview your changes
- git: use version control on your PC
- github: clone the Dictionary repository in your github account, modify and submit
- recommended: combine RStudio with git and github

# Low tech approach

Take one of the chapter .qmd files and improve it or write a new chapter using any editor. 
Run the risk of errors, hope for the best and send us the result.

# Rendering the Dictionary

More fun and less error-prone is rendering your chapter (or the complete dictionary with your chapter) yourself. 
There you see the success of your work and can detect and correct mistakes. To do so you need to install software on your PC.

## Installing the IDE

- install R from [CRAN](https://cran.r-project.org/)
- install RStudio from [posit](https://posit.co/download/rstudio-desktop/)
- install TinyTex from the terminal in RStudio

```{}
quarto install TinyTex
quarto update TinyTex
```

- install R packages

```{R}
install.packages("servr")
install.packages("quarto")
install.packages("pak")
pak::pak("ropensci-review-tools/babelquarto")
```

## Without github account

For regular contributions it is easier to work with a github account (see below). However, if you just want to try editing the Dictionary or plan few contributions, you can can simply download a zip from `github`:

- for learning download [disinfoquick](github.com/disinfoquick) as a zip file
- or download the full [disinfodict](github.com/disinfodict) as a zip file
- uncompress on your PC
- open .RProj project file with RStudio
- render (see below)
- make changes to a chapter file .qmd (or write a new chapter)
- preview changes (see below)
- finally render
- send us your chapter file .qmd (plus images or .bib for literature references)
- to: TODO

## Multilingual rendering

Full rendering takes a moment, but you should render once to check your current setup works fine.

### Full rendering

```{R}
babelquarto::render_book(site_url = "http://127.0.0.1:4321")
```

This should create a `_book` folder with html, pdf and epub in all available languages (default english and a subfolder `de` for German). 

### start the http server

For proper browsing (including search) you need a running http-server. The following is not fast but serves the purpose:

```{R}
ret <- servr::httw("_book", host="127.0.0.1", port="4321")
```

Now you should see the Dictionary in the viewer pane of RStudio. By clicking on the <show in new window>-button you can see it in you default browser (Chrome, Firefox, Edge).

### stop the http server

```{R}
ret$stop_server()
```

## Preview changes 

Rendering the complete Dictionary to verify small changes is annoyingly slow. For a better experience you can either work within the minimalistic `disinfoquick` repository, and/or you can preview changes:

### Preview the english version

```{R}
quarto::quarto_preview()
```
This will monitor the English chapters for saved changes, update and show the result.

### preview english folder

```{R}
quarto::quarto_preview("example_part")
```

This will monitor the English chapters in folder `example_part` for saved changes, update and show the result.

### preview single file

This is like checking *Render on Save* in RStudio.

```{R}
quarto::quarto_preview("example_part/my_chapter.de.qmd")
```

It will monitor the file  `example_part/my_chapter` for saved changes, update and show the result.

### stop the preview server
```{R}
quarto::quarto_preview_stop()
```


# Git version control

RStudio integrates with the`git` version control system. If you don't have `git install it

- install [git](https://git-scm.com/downloads)

Note that `git` will tag your commits with a user name and email. Once you have created your local repository (see under *Github*), check your default and repository git configuration from the terminal: 

```{}
git config --list --global 
git config --list 
```

and make sure the `user.nam` and `user.email` fits your needs and does not break your anonymity on github, if that is important to you!  

You can set the git default config with 

```{}
git config --global user.name "<desired default name>" 
git config --global user.email "<desired default email>" 
```

and you can overwrite the default setting with a repository config in the repository folder with

```{}
git config user.name "<desired local name for the repository>" 
git config user.email "<desired local email for the repository>" 
```

We don't need more git details here and combine `git` in a workflow with *RStudio* and *github*:


# Github code

The Desinformation Dictionary is hosted on [github](https://github.com/disinfodict). 
Github allows you clone the Dictionary, improve it, and suggest your improvements for inclusion. This can be done *with* or *without* a local copy on your PC, and *with* or *without* using RStudio. We recommend combining github, git and RStudio. 

## Github account

- if you don't have a github account (or don't want to be identified with it) create a [github account](https://github.com/signup)

## Github flow

The basic idea is more ro less following the [github flow](https://docs.github.com/en/get-started/using-github/github-flow) like it is done for open-source software. Theoretically you can modify chapters solely on github. But as said before, it is more fun and less error prone to render your changes on your PC (with [quarto](https://quarto.org)) from within [RStudio](https://posit.co/download/rstudio-desktop/). Here is a [quick intro to `git` and `github` with RStudio](https://r-bio.github.io/intro-git-rstudio/). 

## Dictionary flow

To shield you from any complexities with using the git command line, we suggest the following workflow:

- on github for learning fork the [disinfoquick](github.com/disinfoquick) repository
- or fork the full [disinfodict](github.com/disinfodict) repository
- create a branch on github
- clone your github repository (including the branch) to your local PC
  1. On GitHub, navigate to the Code tab of the repository.
  2. On the right side of the screen, click Clone or download.
  3. Click the Copy to clipboard icon to the right of the repository URL.
  4. Open RStudio on your local environment.
  5. Click File, New Project, Version Control, Git.
  6. Paste the repository URL and enter TAB to move to the Project directory name field.
  7. Click Create Project.
  8. Click the Git-Button and choose the Commit-menu and switch from 'master' to your branch (now the files in the repository folder represent your branch, not the master). 
  9. Security: check (and correct) your git.user and git.email (see above) 
- render the dictionary (see below)
- modify your local branch
- preview changes
- repeat modifying
- end of day render the full dictionary and check
- commit your changes to your local branch
- push your changes to your remote branch on github
- repeat until you have completed your objective 
- create a "pull request" from your github branch to the disinfodict repository (if OK, the disinfodict maintainer will merge your branch and delete it) 


# Deployment

## Render

```{R}
babelquarto::render_book()
```

## E-book check

### install epubcheck

```{}
sudo apt install epubcheck
```

### basic check

```{}
epubcheck _book/Disinformation-Dictionary.epub
epubcheck _book/de/Desinformations-Wörterbuch.epub
```

### accessibility check at 

Go to [check website](https://bacc.dzblesen.de/)

<!--
#list all cyrillic supporting fonts from terminal
fc-list :lang=ru

# broken and requires root access
sudo apt install npm
sudo apt install nodejs
npm install @daisy/ace -g
-->
  