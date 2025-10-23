---
title: "Disinfo Dictionary"
format: html
execute: 
  enabled: false
---

# Contribute

You can contribute to the Disinfo Dictionary in multiple ways

- low tech approach: just modify a chapter file or write a new one
- Rstudio: render Dictionary on your PC and preview your changes
- git: use version control on your PC
- github: clone the Dictionary repository in your github account, modify and submit
- recommended: combine RStudio with git and github

To submit you contribution use the email address in the [dictionary](https://disdict.org/intro/principles#contribute), for many submissions learn how to use pull requests, see below [Dictionary flow].


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
- to: contribute@disdict.org

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

This will monitor the English chapters in folder `examplepart` for saved changes, update and show the result.

### preview single file

This is like checking *Render on Save* in RStudio.

```{R}
quarto::quarto_preview("examplepart/mychapter.de.qmd")
```

It will monitor the file  `examplepart/mychapter` for saved changes, update and show the result.

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

## Measuring dictionary status

```{R}
en <-  setdiff(dir(pattern="[.]qmd$", recursive=T), c("impressum.qmd", "impressum.de.qmd", "404.qmd", "README.qmd"))
de <- en[grep("[.]de[.]qmd$", en)]
ua <- en[grep("[.]ua[.]qmd$", en)]
en <- setdiff(en, c(de, ua))
demiss <- setdiff(sub("[.]qmd", ".de.qmd", en), de)
if (length(demiss)){
  cat("Missing: .de.qmd\n")
  print(demiss)
  # for (f in demiss){
  #   file.copy(sub("[.]de[.]qmd",".qmd",f), f)
  #   x <- readLines(f)
  #   x <- sub('title="Myth"','title="Mythos"', x)
  #   x <- sub('title="Truth"','title="Wahrheit"', x)
  #   writeLines(x, f)
  # }
  # for (f in demiss){
  #   system(paste("gedit", f))
  # }
}
names(en) <- sub("[.]qmd", "", en)
names(de) <- sub("[.]qmd", "", de)
enstatus <- sapply(en, function(i){
  x <- paste(readLines(i), collapse=" ")
  y <- strsplit(x, "##")[[1]]
  lipsum <- grep("lipsum|TODO", y, ignore.case = TRUE)
  abstract <- length(grep("abstract: >", y)) == 0 & length(grep("index", i)) == 0
  n <- length(y) + 1
  k <- n - length(lipsum) - abstract
  p <- k/n
  p
})
destatus <- sapply(de, function(i){
  x <- paste(readLines(i), collapse=" ")
  y <- strsplit(x, "##")[[1]]
  lipsum <- grep("lipsum|TODO", y, ignore.case = TRUE)
  abstract <- length(grep("abstract: >", y)) == 0 & length(grep("index", i)) == 0
  n <- length(y) + 1
  k <- n - length(lipsum) - abstract
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
dictionarystatus <- cbind(en=100*enstatus, ".de"=rep(0, length(enstatus)))
dictionarystatus[,2] <- 0
rownames(dictionarystatus) <- names(enstatus)
if (length(destatus))
  dictionarystatus[sub("\\.de","",names(destatus)),2] <- 100*destatus
dictionarystatus <- as.data.frame(round(dictionarystatus))
dereserved <- names(dereserved)[dereserved]
if (length(dereserved))
  enreserved[sub("\\.de","",names(dereserved))] <- TRUE
dictionarystatus$reserved <- ifelse(enreserved, 'reserved', '')
save(dictionarystatus, file = "status.RData")
```

## Set default publication date

The current datetime GMT set here is used as meta name date in html files where we cannot rescue the publication date of the *.qmd file (index.qmd). 

```{R}
defaultdate <- Sys.time()
f <- "./in_header.html"
lines <- readLines(f)
i <- grep('<meta name="date" content="', lines)
lines[i] <- paste0('<meta name="date" content="', format(defaultdate, '%Y-%m-%dT%H:%M:%S', tz='Europe/London'), '">')
writeLines(lines, f)
```


## After technical changes: update qmd files dates

```{R}
qmdfiles <- dir(".", "[.]qmd", recursive=TRUE, include.dirs = TRUE, full.names = TRUE)
qmdfiles <- qmdfiles[-match("./README.qmd", qmdfiles)]
Sys.setFileTime(qmdfiles, defaultdate)
```


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

We use  [ACE by Daisy](https://daisy.org/activities/software/ace/), the [ACE-app is easy to intall and use](https://daisy.github.io/ace/getting-started/ace-app/)


## Set baseurl and ccs

```{R}
#base <- "https://disinfodict[.]pages[.]dev"  # [.] for regexp
#base <- "https://disinfodict[.]org"  # [.] for regexp
base <- "https://disdict[.]org"  # [.] for regexp
baseurl <- gsub("\\[[.]\\]",".", base)
ccs <- c("en","de")  # default language first
dofixhtml <- TRUE
dofiltersitemap <- TRUE
load("status.RData")
```

## Remove unwanted files, copy fixes

- Babelquarto copied 404.html to <cc> folders. To avoid duplicates we delete those and later rename all links to the canonical one.
- Babelquarto has index.html redirected to index.<cc>.html. Google doesn't like redirection. Hence we delete index.html and later rename all <cc>.index.<cc>.html to <cc>.index.html.
- Babelquarto copied impressum.html to <cc> folders, instead of compipiling impressum.<cc>.qmd. To avoid duplicates we delete those copies and later copy from impressum.<cc>.html
- Babelquarto copied (broken) sitemap.xml. Hence we delete them all and later synthesize one multilingual sitemap.

```{R}
# for secondary languages 
if (dofixhtml) for (cc in ccs[-1]){
  file.remove(paste0("_book/", cc, "/404.html"))        
  file.remove(paste0("_book/", cc, "/index.html"))      # we still have index.<cc>.html
  file.remove(paste0("_book/", cc, "/impressum.html"))  # impressum.<cc>.qmd not compiled, we later copy impressum.<cc>.html
  file.remove(paste0("_book/", cc, "/sitemap.xml"))     # the remaining sitemap.xml is replaced with a synthesized sitemap.xml later
  for (cc in ccs[-1]){
    file.copy(paste0('impressum.', cc, '.html'), paste0('_book/', cc, '/impressum.', cc, '.html'))
  }
}
```

## Get qmd dates and fix html files

Quarto seems not to set the meta name date: we determine the last-modified date of the qmd file, set it as meta name date and store it for fixing sitemap.xml.
Note that we assum now, that each html has a corresponding qmd file.

```{R}
htmlfilenames_onlydefault = c("404.html")
htmlfiles <- dir("_book", "[.]html", recursive=TRUE, include.dirs = TRUE, full.names = TRUE)
for (cc in ccs[-1]){
  qmdfiles <- sub(paste0('^', cc, '/'), '', sub('[.]html','.qmd', substr(htmlfiles, 7, nchar(htmlfiles))))
}
htmlfilenames <- basename(htmlfiles)
qmdfilenames <- basename(qmdfiles)
stopifnot(all(file.exists(qmdfiles)))  # check for corresponding qmd file
urls <-  sub('_book', baseurl, htmlfiles)
dates <- rep(Sys.time(), length(htmlfiles))
names(dates) <- htmlfiles
for (i in seq_along(htmlfiles)){
  h <- htmlfiles[i]
  q <- qmdfiles[i]
  hn <- htmlfilenames[i]
  qn <- qmdfilenames[i]
  u <- urls[i]
  date <- file.mtime(q)
  dates[i] <- date
  lines <- readLines(h)
  if (dofixhtml){
    # update the date
    l <- grep('<meta name="date" content="', lines)
    lines[l] <- paste0('<meta name="date" content="', format(date, '%Y-%m-%dT%H:%M:%S', tz="GMT"),'">')
    # babelquarto did not treat canonical links, hence needs fixing
    l <- grep('<link rel="canonical"', lines)
    lines[l] <- sub(paste0(base, '/.+[.]html'), u, lines[l])
    for (cc in rev(ccs[-1])){
      # -- links index.<cc>.html in index.html umwandeln --
      # fix absolute index paths
      lines <- gsub(paste0('("', baseurl, '/', cc,  ')(/index[.]', cc , '[.]html")'), '\\1/index.html"', lines)
      # fix relative index paths
      lines <- gsub(paste0('("[^h][^"]*)(/index[.]', cc, '[.]html")'), '\\1/index.html"', lines)
      # -- links impressum.html in impressum.<cc>.html umwandeln --
      if (length(grep(paste0('/', cc, '/'), h))){
        l <- grep('<a class="nav-link" href="[.][.]?/impressum.html">', lines)
        if (length(l))
          lines[l] <- gsub('(<a class="nav-link" href="[.][.]?)(/impressum.html)">', paste0('\\1/impressum.',cc,'.html">'), lines[l])
      }
    }
    if (hn %in% htmlfilenames_onlydefault){
      l <- grep('<link rel="alternate" hreflang=', lines)
      if (length(l))
        lines <- lines[-l]
    }
    writeLines(lines, h)
  }
}
f <- paste0('_book/', cc, '/search.json')
lines <- readLines(f)
l <- grep('"objectID":', lines)
lines[l] <- sub(paste0('index[.]', cc, '[.]html'), 'index.html', lines[l])
lines[l] <- sub('impressum[.]html', paste0('impressum.', cc, '.html'), lines[l])
l <- grep('"href":', lines)
lines[l] <- sub(paste0('index[.]', cc, '[.]html'), 'index.html', lines[l])
lines[l] <- sub('impressum[.]html', paste0('impressum.', cc, '.html'), lines[l])
if (dofixhtml) for (cc in rev(ccs[-1])){
  writeLines(lines, f)
}
rm(qmdfiles, qmdfilenames, htmlfilenames, urls)
```

## Rename all index.<cc>.html

Babelquarto has index.html redirected to index.<cc>.html. Google doesn't like redirection. Hence we deleted index.html and here rename all <cc>.index.<cc>.html to <cc>.index.html.

```{R}
# for secondary languages 
if (dofixhtml) for (cc in ccs[-1]){
  file.rename(paste0("_book/", cc, "/index.", cc, ".html"), paste0("_book/", cc, "/index.html"))  # rename the real one
  htmlfiles <- sub(paste0("_book/", cc, "/index.", cc, ".html"), paste0("_book/", cc, "/index.html"), htmlfiles)
}
names(dates) <- htmlfiles
```


## List of all links to check

```{R}
links <- NULL
for (h in htmlfiles){
  x <- readLines(h)
  y <- gregexpr('\\shref="[^"]+[.]html"', x, perl = TRUE)
  y <- lapply(seq_along(y), function(j){
    a <- y[[j]]
    if (a[1]==-1)
      NULL
    else{
      n <- attr(a, "match.length")
      attributes(a) <- NULL
      cbind(j, a, a + n - 1L)
    }
  })
 p <- do.call("rbind", y)
 z <- substr(x[p[,1]], p[,2], p[,3])
 mat <- cbind(source=sub('_book', baseurl, h), link=z)
 stopifnot(is.matrix(mat))
 links <- rbind(links, mat)
}
# extract the url itself
links[,2] <- gsub('(\\shref=")([^"]+)(")', '\\2', links[,2])

# standardize the url
l0 <- substr(links[,2], 1, 8) == 'https://' | substr(links[,2], 1, 7) == 'http://'
l1 <- substr(links[,2], 1, 1) == '/'
if (sum(l1)){
  links[l1,2] <- paste0(baseurl, links[l1,2])
  # 
}
l2 <- !(l0 | l1)  # '.' or filename only
if (sum(l2)){
  links[l2,2] <- paste0(sub('[^/]+.html', '', links[l2,1]), links[l2,2])
  # 
}
links[,2] <- sapply(strsplit(links[,2], '/'), function(tokens){
  w <- which(tokens=='..')
  stopifnot(length(w) <= 1) # multiple ../.. not handled yet
  if (length(w))
    tokens <- tokens[-c(w, w-1L)]
  tokens <- tokens[tokens!='.']
  paste(tokens, sep="", collapse="/")
})
links <- links[!duplicated(links[,2]),]

cloudflare <- links[,2] 
i <- grep(base, cloudflare)
cloudflare[i] <- sub(paste0(base, '/index[.]html'), baseurl, cloudflare[i])
cloudflare[i] <- sub('/index[.]html', '/', cloudflare[i])
cloudflare[i] <- sub('[.]html', '', cloudflare[i])
links <- cbind(links, cloudflare, NA)
colnames(links) <- c("source","url","cloudflare","ret")
links[grep('impressum', links[,"cloudflare"]),]
```


##  Synthesize Sitemap

- With `dofiltersitemap==TRUE` we only include completed chapters to avoid Google crawling incomplete chapters that Google Search Cosole might judge to be low quality or almost duplicates. 
- Sitemap is designed according to https://developers.google.com/search/docs/specialty/international/localized-versions?hl=en (Not used the advice from https://stackoverflow.com/questions/20330837/multilingual-sitemap-xml-file, the sitemap protocol is at https://www.sitemaps.org/protocol.html)
- Advice what to do if sitemap can't be read: https://www.clickbrown.in/sitemap-could-not-be-read-cloudflare-fix/, note that Google does not like like shared domains such as <whatever>.page.dev/sitemap.xml, not even - cloudflare likes it (fails to trace it with https://developers.cloudflare.com/rules/trace-request/how-to/). 
- Sitemap can be checked after a deployment at https://technicalseo.com/tools/hreflang/ or at https://www.xml-sitemaps.com/validate-xml-sitemap.html 

```{R}
files <- setdiff(htmlfiles, paste0('_book/', c(htmlfilenames_onlydefault, 'impressum.html')))  # hold out rather technical pages
urls <- sub('_book', baseurl, files)
defurls <- urls
for (cc in ccs[-1]){
  defurls <- sub(paste0('/'  , cc, '/'),'/', defurls)
  defurls <- sub(paste0('[.]', cc, '[.]'), '.', defurls)
}
if (dofiltersitemap){
   status <- rowSums(dictionarystatus[,-ncol(dictionarystatus)])/2
   names(status) <- paste0(baseurl, '/', names(status), '.html')
   i <- status[defurls] > 99.9
   files <- files[i]
   urls <- urls[i]
   defurls <- defurls[i]
}
xhtml <- rbind(defurls)
langs <- rbind(rep(ccs[1], length(defurls)))
for (cc in ccs[-1]){
  xhtml <- rbind(xhtml, sub('[.]html',paste0('.', cc, '.html'), sub(base, paste0(baseurl, '/', cc), defurls)))
  langs <- rbind(langs, rep(cc, length(defurls)))
}
xhtml <- paste0('    <xhtml:link rel="alternate" hreflang="',langs ,'" href="', xhtml,'"/>')
dim(xhtml) <- dim(langs)
xhtml <- apply(xhtml, 2, function(x)paste0(x, collapse='\n'))

# We do not mark impressum as priority
#xhtml <- c(xhtml, '')
#files <- c(files, '_book/impressum.html')
#urls <- c(urls, paste0(baseurl, '/impressum.html'))

formatteddates <- paste0(format(dates[files], '%Y-%m-%dT%H:%M:%S', tz="GMT"), '.000Z')

# replace index.<cc>.html with index.html
for (cc in ccs[-1]){
  urls <- sub(paste0('/index[.]', cc, '[.]html'), '/index.html', urls)
  xhtml <- sub(paste0('/index[.]', cc, '[.]html'), '/index.html', xhtml)
}

xml <- paste0('  <url>
    <loc>', urls, '</loc>
    <lastmod>', formatteddates, '</lastmod>
', xhtml, '
  </url>')

f <- file("_book/sitemap.xml", "w")
writeLines('<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">', f)
writeLines(xml, f)
writeLines('</urlset>
', f)
close(f)
```



## Fix cloudflare 

```{R}
# now change all absolute and relative internal links in all html pages
if (dofixhtml) for (h in htmlfiles){
  lines <- readLines(h)
  # index.html is special: is removed completely
  for (cc in ccs){
      if (cc==ccs[1]){
        # without trailing slash
        lines <- gsub(paste0('("', baseurl, ')(/index[.]html")'), '\\1"', lines)
        lines <- gsub('("[^h][^"]*)(/index[.]html")', '\\1"', lines)
      }else{
        # with trailing slash
        lines <- gsub(paste0('("', baseurl, '/', cc,  ')(/index[.]html")'), '\\1/"', lines)
        lines <- gsub(paste0('("[^h][^"]*/',  cc, ')(/index[.]html")'), '\\1/"', lines)
      }
  }  
  # all others have .html removed (without trailing slash)
  lines <- gsub(paste0('"', baseurl, '/"'), paste0('"', baseurl, '"'), lines)
  lines <- gsub(paste0('("', baseurl, '/[^"]+)([.]html")'), '\\1"', lines)
  lines <- gsub('("[^h][^"]*)([.]html")', '\\1"', lines)
  writeLines(lines, h)
}

# now change all absolute links in sitemap.xml
lines <- readLines('_book/sitemap.xml')
for (cc in ccs){
  if (cc==ccs[1]){
    # without trailing slash
    lines <- gsub(paste0('(<loc>', baseurl, ')(/index[.]html</loc>)'), '\\1</loc>', lines)
    lines <- gsub(paste0('("', baseurl, ')(/index[.]html")'), '\\1"', lines)
  }else{
    # with trailing slash
    lines <- gsub(paste0('(<loc>', baseurl, '/', cc, ')(/index[.]html</loc>)'), '\\1/</loc>', lines)
    lines <- gsub(paste0('("', baseurl, '/', cc ,')(/index[.]html")'), '\\1/"', lines)
  }
}
# without trailing slash
lines <- gsub(paste0('(<loc>', baseurl, '/.+)([.]html</loc>)'), '\\1</loc>', lines)
lines <- gsub(paste0('("', baseurl, '/[^"]+)([.]html")'), '\\1"', lines)
writeLines(lines, '_book/sitemap.xml')

# now change in search.json
if (dofixhtml){
  for (cc in ccs){
      if (cc==ccs[1]){
        f <- '_book/search.json'
      }else{
        f <- paste0('_book/', cc, '/search.json')
      }
    lines <- readLines(f)
    # without trailing slash
    l <- grep('"objectID":', lines)
    lines[l] <- sub('[.]html', '', lines[l])
    l <- grep('"href":', lines)
    lines[l] <- sub('[.]html', '', lines[l])
    writeLines(lines, f)
  }
}
```


## Cloudflare Pages _redirects 

A Cloudflare Pages _redirects file is not needed, because Cloudflare Pages signals its trailing-slash policy with 308 codes

```{R}
#f <- file("_book/_redirects", "w")
#writeLines(paste(paste0(baseurl, '/'), baseurl, 301), f)
#for (cc in ccs[-1]){
#  writeLines(paste(paste0(baseurl, '/', cc), paste0(baseurl, '/', cc, '/'), 301), f)
#}
#writeLines(paste(paste0(baseurl, '/*'), paste0(baseurl, '/:splat/'), 301), f)
#close(f)
```


## Cloudflare Pages _headers 

```{R}
f <- file("_book/_headers", "w")
writeLines('
https://:project.pages.dev/*
  X-Robots-Tag: noindex

https://:version.:project.pages.dev/*
  X-Robots-Tag: noindex

https://*.pdf
  X-Robots-Tag: noindex

https://*.epub
  X-Robots-Tag: noindex

https://disinfodict.org/index*
  X-Robots-Tag: noindex

https://disdict.org/index*
  X-Robots-Tag: noindex

https://disinfodict.org/de/index*
  X-Robots-Tag: noindex

https://disdict.org/de/index*
  X-Robots-Tag: noindex
', f)
close(f)
```


## Fix html file dates

```{R}
if (dofixhtml)
  Sys.setFileTime(htmlfiles, dates[htmlfiles])
```


## pre-deployment check

```{R}
htmlfiles <- c("_book/sitemap.xml", dir("_book", "[.]html", recursive=TRUE, include.dirs = TRUE, full.names = TRUE))
for (h in htmlfiles){
  lines <- readLines(h)
  # any href with single quote?
  g <- grep("href *= *'", lines, value = TRUE); if (length(g)){cat(h, "(href single quote): ", g, "\n", sep=""); stop()}
  root <- c(baseurl, "")
  sta <- c('href *= *"','>')
  sto <- c('"','<')
  for (r in root){
    for (i in seq_along(sta)){
      s <- sta[i]
      t <- sto[i]
      g <- grep(paste0(s, r, "/index[.]html", t), lines, value = TRUE); if (length(g)){cat("\n", h, "_", s, "_", t, ": ", g, "\n", sep=""); stop()}
      g <- grep(paste0(s, r, "/index", t), lines, value = TRUE); if (length(g)){cat("\n", h, "_", s, "_", t, ": ", g, "\n", sep=""); stop()}
      g <- grep(paste0(s, r, '/de/index[.]html', t), lines, value = TRUE); if (length(g)){cat("\n", h, "_", s, "_", t, ": ", g, "\n", sep=""); stop()}
      g <- grep(paste0(s, r, "/de/index", t), lines, value = TRUE); if (length(g)){cat("\n", h, "_", s, "_", t, ": ", g, "\n", sep=""); stop()}
      g <- grep(paste0(s, r, '/', t), lines, value = TRUE); if (length(g)){cat("\n", h, "_", s, "_", t, ": ", g, "\n", sep=""); stop()}
      g <- grep(paste0(s, r, '/de', t), lines, value = TRUE); if (length(g)){cat("\n", h, "_", s, "_", t, ": ", g, "\n", sep=""); stop()}
    }
  }
  g <- grep("/Disinfor-Dictionary[.]pdf", lines, value = TRUE); if (length(g)){cat("\n", h, ": ", g, "\n", sep=""); print(g)}
  g <- grep("/Disinfor-Dictionary[.]epub", lines, value = TRUE); if (length(g)){cat("\n", h, ": ", g, "\n", sep=""); print(g)}
}
```


## Check the links

```{R}
todo <- seq_len(nrow(links))[is.na(links[,"ret"]) | links[,"ret"]!="200"]
for (i in todo){
  link <- links[i,]
  cat("\n", i, " ", link["source"], " ", link["cloudflare"])
  Sys.sleep(runif(1, 1, 2))
  o <- attr(curlGetHeaders(link[["cloudflare"]], redirect = FALSE, verify = FALSE), "status")
  link["ret"] <- o
  links[i,] <- link
  if (o != 200){
    cat(" BROKEN ", o, "\n")
  }else{
    cat("     OK ", o, "\n")
  }
} 
```

```{R}
rownames(links) <- seq_len(nrow(links))
d <- links[links[,"ret"]!="200",c("cloudflare","ret")]
d <- d[order(d[,"ret"]),2:1]
cat(paste("\n", rownames(d), d[,1], d[,2], sep=" "), file="~/test.txt")
```



## Curl check

curl -I -L https://disdict.org/


# Expert use only

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

