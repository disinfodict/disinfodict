---
title: "Disinformation Dictionary"
format: html
execute: 
  enabled: false
---

# Conribute

You can contribute to the Disinformation Dictionary in multiple ways

- low tech approach: just modify a chapter file or write a new one
- Rstudio: render Dictionary on your PC and preview your changes
- git: use version control on your PC
- github: clone the Dictionary repository in your github account, modify and submit
- recommended: combine RStudio with git and github

To submit you contribution use the email address in the [dictionary](https://disinfodict.pages.dev/intro/principles#contribute), for many submissions learn how to use pull requests, see below [Dictionary flow].


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
- install the Segoe UI fonts (or change `mainfont: "Segoe UI"` to a font you have or comment that line out)

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
- to: contribute@disinfodict.org

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

The Disinformation Dictionary is hosted on [github](https://github.com/disinfodict). 
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
epubcheck _book/Disinfo-Dictionary.epub
epubcheck _book/de/Desinfo-Lexikon.epub
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


# Expert use only

## Measuring dictionary status

```{R}
en <-  setdiff(setdiff(dir(pattern="[.]qmd$", recursive=T), "README.qmd"), "status/status.qmd")
en <- en[grep("/", en)] 
de <- en[grep("[.]de[.]qmd$", en)]
ua <- en[grep("[.]ua[.]qmd$", en)]
en <- setdiff(en, c(de, ua))
names(en) <- sub("[.]qmd", "", en)
names(de) <- sub("[.]qmd", "", de)
enstatus <- sapply(en, function(i){
  x <- paste(readLines(i), collapse=" ")
  y <- strsplit(x, "##")[[1]]
  lipsum <- grep("lipsum|TODO", y, ignore.case = TRUE)
  n <- length(y)
  k <- n - length(lipsum)
  p <- k/n
  p
})
destatus <- sapply(de, function(i){
  x <- paste(readLines(i), collapse=" ")
  y <- strsplit(x, "##")[[1]]
  lipsum <- grep("lipsum|TODO", y, ignore.case = TRUE)
  n <- length(y)
  k <- n - length(lipsum)
  p <- k/n
  p
})
enreserved <- sapply(en, function(i){
  x <- paste(readLines(i), collapse=" ")
  length(grep("\\{\\{ reserved \\}\\}", x, ignore.case = TRUE))>0
})
dereserved <- sapply(de, function(i){
  x <- paste(readLines(i), collapse=" ")
  length(grep("\\{\\{ reserved \\}\\}", x, ignore.case = TRUE))>0
})
d <- cbind(en=100*enstatus, ".de"=rep(0, length(enstatus)))
d[,2] <- 0
rownames(d) <- names(enstatus)
if (length(destatus))
  d[sub("\\.de","",names(destatus)),2] <- 100*destatus
d <- as.data.frame(round(d))
dereserved <- names(dereserved)[dereserved]
if (length(dereserved))
  enreserved[sub("\\.de","",names(dereserved))] <- TRUE
d$reserved <- ifelse(enreserved, 'reserved', '')
save(d, file = "status.RData")
```

## Mesasuring dictionary size

```{R}
en <-  setdiff(dir(pattern="[.]qmd$", recursive=T), "README.qmd")
en <- en[-grep("[.][a-z][a-z][.]", en)]
de <- dir(pattern="[.]de[.]qmd$", recursive=T)
names(en) <- en
names(de) <- de

enwords <- sapply(en, function(i){
 x <- readLines(i)
 lipsum <- length(unlist(grep("\\{\\{< lipsum", x))) > 0
 y <- sum(lengths(strsplit(x, ' ')))
 ifelse(lipsum, NA, y)
})
dewords <- sapply(de, function(i){
 x <- readLines(i)
 lipsum <- length(unlist(grep("\\{\\{< lipsum", x))) > 0
 y <- sum(lengths(strsplit(x, ' ')))
 ifelse(lipsum, NA, y)
})

enlinks <- sapply(en, function(i){
 x <- readLines(i)
 lipsum <- length(unlist(grep("\\{\\{< lipsum", x))) > 0
 names(x) <- seq_along(x)
 y <- sum(sapply(gregexpr("(\\(|\\{)((http://|https://)[[:alpha:]0-9.:/#?=_&\\\\-]+)", x), function(l){
   if (l[1]==-1) {
     0
   }else{
     length(l)
   }
 }))
 ifelse(lipsum, NA, y)
})
length(en)
length(de)
length(en)*mean(enwords, na.rm=TRUE)
length(en)*mean(dewords, na.rm=TRUE)
summary(enwords)
summary(dewords)
length(en)*mean(enlinks, na.rm=TRUE)
summary(enlinks)
```



## Footnote reorganisation

```{R}
for (i in grep("/", dir(pattern="[.]qmd", recursive=T), value=TRUE)){
 cat(i)
 x <- readLines(i)
 names(x) <- seq_along(x)
 y <- gregexpr("\\[\\^[0-9a-zA-Z-]+\\]", x)
 y <- lapply(seq_along(y), function(j){
   a <- y[[j]]
   if (a[1]==-1)
     NULL
   else
     cbind(row=j, start=as.vector(a), stop=as.vector(a)+attr(a, "match.length")-1L)
 })
 names(y) <- seq_along(x)
 z <- do.call("rbind", y)
 if (!is.null(z)){
     n <- sapply(y, function(a){if (is.null(a)) 0 else nrow(a)})
     oldid <- substr(x[z[,"row"]], z[,"start"], z[,"stop"])
     toldid <- sapply(split(oldid, oldid), length)
     #if (any(toldid!=2)){
     #  print(toldid[toldid!=2])
     #}
     tnewid <- toldid
     tnewid[] <- paste0("[^",gsub("/","-",substr(i, 1, nchar(i)-4)),"-",seq_along(toldid),"]")
     newid <- tnewid[oldid]
     for (j in rev(seq_along(newid))){
       k <- z[j,"row"]
       s <- x[k]
       s1 <- if (z[j,"start"]>1) substr(s, 1, z[j,"start"]-1L)
       s2 <- if (z[j,"stop"]<nchar(s)) substr(s, z[j,"stop"]+1L, nchar(s))
       s3 <- paste0(s1, newid[j], s2)
       x[k] <- s3
     }
     writeLines(x, i)
     cat(" done\n") 
   }
}
```

### Checking formatted links


```{R}
require(curl)
hand <- new_handle()
handle_setheaders(hand
, "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101 Firefox/128.0" 
, "Accept" = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/png,image/svg+xml,*/*;q=0.8" 
, "Accept-Language" = "de,en-US;q=0.7,en;q=0.3" 
, "Accept-Encoding" = "gzip, deflate, br, zstd" 
, "DNT" = "1" 
, "Sec-GPC" = "1" 
, "Connection" = "keep-alive" 
, "Upgrade-Insecure-Requests" = "1" 
, "Sec-Fetch-Dest" = "document" 
, "Sec-Fetch-Mode" = "navigate" 
, "Sec-Fetch-Site" = "none" 
, "Sec-Fetch-User" = "?1" 
, "Priority" = "u=0, i"
)
fi <- file("log.txt", open="w")
for (i in grep("/", dir(pattern="[.](bib|qmd)", recursive=T), value=TRUE)){
 cat("\n", i, "\n", file=fi)
 x <- readLines(i)
 names(x) <- seq_along(x)
 y <- gregexpr("(\\(|\\{)((http://|https://)[[:alpha:]0-9.:/#?=_&\\\\-]+)", x, perl=TRUE)
 y <- lapply(seq_along(y), function(j){
   a <- y[[j]]
   if (a[1]==-1)
     NULL
   else
     cbind(row=j, start=attr(a, "capture.start")[,2], stop=attr(a, "capture.start")[,2]+attr(a, "capture.length")[,2]-1L)
 })
 names(y) <- seq_along(x)
 z <- do.call("rbind", y)
 if (!is.null(z)){
     n <- sapply(y, function(a){if (is.null(a)) 0 else nrow(a)})
     oldid <- substr(x[z[,"row"]], z[,"start"], z[,"stop"])
     for (j in rev(seq_along(oldid))){
       k <- z[j,"row"]
       s <- x[k]
       h <- oldid[j]
       u <- url(h)
       Sys.sleep(runif(1, 1, 2))
       o <- curl_fetch_memory("https://www.nato.int/cps/en/natohq/opinions_224174.htm/head", handle = hand)$status_code
       if (o != 200){
         cat("\nrow=", z[j,"row"], "  start=", z[j,"start"], "  stop=", z[j,"stop"], "BROKEN ", o, " ", h, "\n", file=fi)
       }else{
       close(u)
       cat("\nrow=", z[j,"row"], "  start=", z[j,"start"], "  stop=", z[j,"stop"], "  OK   ", o, " ",  h, "\n", file=fi)
       }
     }
   }
} 
close(fi)
#gsub("(^|[^[\\[\\(\\`)]]?)((http://|https://)[[:alpha:]0-9./#?=_&\\\\-]+)", "\\1[\\2](\\2)", x)
```


### Checking and formatting unformatted links


```{R}
require(curl)
hand <- new_handle()
handle_setheaders(hand
, "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101 Firefox/128.0" 
, "Accept" = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/png,image/svg+xml,*/*;q=0.8" 
, "Accept-Language" = "de,en-US;q=0.7,en;q=0.3" 
, "Accept-Encoding" = "gzip, deflate, br, zstd" 
, "DNT" = "1" 
, "Sec-GPC" = "1" 
, "Connection" = "keep-alive" 
, "Upgrade-Insecure-Requests" = "1" 
, "Sec-Fetch-Dest" = "document" 
, "Sec-Fetch-Mode" = "navigate" 
, "Sec-Fetch-Site" = "none" 
, "Sec-Fetch-User" = "?1" 
, "Priority" = "u=0, i"
)
#require(httr)
# headers = c(
#   `User-Agent` = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101 Firefox/128.0',
#   `Accept` = 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/png,image/svg+xml,*/*;q=0.8',
#   `Accept-Language` = 'de,en-US;q=0.7,en;q=0.3',
#   `Accept-Encoding` = 'gzip, deflate, br, zstd',
#   `DNT` = '1',
#   `Sec-GPC` = '1',
#   `Connection` = 'keep-alive',
#   `Upgrade-Insecure-Requests` = '1',
#   `Sec-Fetch-Dest` = 'document',
#   `Sec-Fetch-Mode` = 'navigate',
#   `Sec-Fetch-Site` = 'none',
#   `Sec-Fetch-User` = '?1',
#   `Priority` = 'u=0, i'
# )
# httr::HEAD(url = 'https://www.nato.int/cps/en/natohq/opinions_224174.htm', httr::add_headers(.headers=headers)), times=1)$status_code
fi <- file("log.txt", open="w")
for (i in grep("/", dir(pattern="[.]qmd", recursive=T), value=TRUE)){
 cat("\n", i, "\n", file=fi)
 x <- readLines(i)
 names(x) <- seq_along(x)
 y <- gregexpr("(^|[^[\\[\\(\\`)]]?)((http://|https://)[[:alpha:]0-9.:/#?=_&\\\\-]+)", x, perl=TRUE)
 y <- lapply(seq_along(y), function(j){
   a <- y[[j]]
   if (a[1]==-1)
     NULL
   else
     cbind(row=j, start=attr(a, "capture.start")[,2], stop=attr(a, "capture.start")[,2]+attr(a, "capture.length")[,2]-1L)
 })
 names(y) <- seq_along(x)
 z <- do.call("rbind", y)
 if (!is.null(z)){
     n <- sapply(y, function(a){if (is.null(a)) 0 else nrow(a)})
     oldid <- substr(x[z[,"row"]], z[,"start"], z[,"stop"])
     for (j in rev(seq_along(oldid))){
       k <- z[j,"row"]
       s <- x[k]
       h <- oldid[j]
       u <- url(h)
       Sys.sleep(runif(1, 1, 2))
       o <- curl_fetch_memory("https://www.nato.int/cps/en/natohq/opinions_224174.htm/head", handle = hand)$status_code
       if (o != 200){
         cat("\nrow=", z[j,"row"], "  start=", z[j,"start"], "  stop=", z[j,"stop"], "BROKEN ", o, " ", h, "\n", file=fi)
       }else{
       close(u)
       cat("\nrow=", z[j,"row"], "  start=", z[j,"start"], "  stop=", z[j,"stop"], "  OK   ", o, " ",  h, "\n", file=fi)
         s1 <- if (z[j,"start"]>1) substr(s, 1, z[j,"start"]-1L)
         s2 <- if (z[j,"stop"]<nchar(s)) substr(s, z[j,"stop"]+1L, nchar(s))
         s3 <- paste0(s1, "[", h, "](", h, ")", s2)
         x[k] <- s3
       }
     }
     #writeLines(x, i)
   }
} 
close(fi)
#gsub("(^|[^[\\[\\(\\`)]]?)((http://|https://)[[:alpha:]0-9./#?=_&\\\\-]+)", "\\1[\\2](\\2)", x)
```
