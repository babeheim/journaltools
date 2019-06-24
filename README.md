
journaltools
============

Package `journaltools` is a simple set of R commands for managing a plaintext journal.

The idea behind a plaintext journal is simple: you keep posts in one text file, seperated chronologically by some special divider. In my journals, I begin every post with the date, formatted YYYY-MM-DD, followed by a hyphen and title. Posts are seperated by three new empty lines.

## Requirements
- R (3.3.1 or greater) https://cran.r-project.org/

## Installation

Install with the `devtools` package via

```
devtools::install_github("babeheim/journaltools")

```

## Usage

Here's an example document with several posts:

```

2018-03-05 - journaltools to-dos

add man pages for each of the functions [x]
finish overview vignette [x]



2018-02-01 - February #refs

https://agilescientific.com/blog/2017/12/14/no-more-rainbows

Reproducible and Replicable Computational Fluid Dynamics: It’s Harder Than You Think - Abstract:
Completing a full replication study of the authors' previously published findings on bluff-body aerodynamics was harder than they thought, despite them having good reproducible-research practices, such as sharing their code and data openly. Here's what they learned from three years, four computational fluid dynamics codes, and hundreds of runs.

Core principles of evolutionary medicine: A Delphi study 
Daniel Z Grunspan  Randolph M Nesse  M Elizabeth Barnes Sara E Brownell
Evolution, Medicine, and Public Health, Volume 2018, Issue 1, 1 January 2018, Pages 13–23, https://doi.org/10.1093/emph/eox025

Market Integration Predicts Human Gut Microbiome Attributes across a Gradient of Economic Development
Keaton Stagaman, Tara J. Cepon-Robins, Melissa A. Liebert, Theresa E. Gildner, Samuel S. Urlacher, Felicia C. Madimenos, Karen Guillemin, J. Josh Snodgrass, Lawrence S. Sugiyama, Brendan J. M. Bohannan



2017-12-08 - new audio recorder notes

at minimum mp3 quality, I can still understand the audio no problem
half a megabyte for 1 minute of audio!, so an hour is only about 30 MB

lets say 60 megs a day
thats 16 days x 60 megs = 1 GB
22 Gb to record a whole year 



2017-12-08 - mounting an sd card #unix

sudo fdisk -l

sudo mount --options remount,rw /dev/sdd

Replace /dev/sdd with your SDHC drive, you can find it using fdisk -l.



2017-12-06 - tictoc tests #rstats

library(tictoc)

tic(msg="first test of tictoc")
Sys.sleep(0.5)
toc()

tic.log(format=TRUE)
tic.clearlog()

tic(msg="first test of tictoc")
Sys.sleep(0.5)
toc(log=TRUE)

tic(msg="second test of tictoc")
Sys.sleep(1)
toc(log=TRUE)

tic.log(format=TRUE)

x <- unlist(tic.log())



2017-11-10 - using cp function in OSX terminal

cp -nv /Volumes/"time allocation interview"/* "/Volumes/ecology/Wave1/time allocation interview"



2017-11-09 - next steps on CAC analysis

- make graphs of the results of the models, linear operator by age, etc.
- rewrite code to use an anonymized dataset
- clean up regression tables, put those into writeup with graphs
- circulate to coauthors



2017-11-09 - dna #clippings #art

  A➖➖➖T
  A➖➖➖T
   G➖➖C
    C➖G
     TA
    C➖G
   G➖➖C
  A➖➖➖T
  G➖➖➖C
   T➖➖A
    C➖G
     GC
    A➖T
   T➖➖A
  C➖➖➖G
  A➖➖➖T
   G➖➖C
    T➖A
     CG
    G➖C
   T➖➖A

```

Beyond the date, there's no formal slots for anything else (e.g. author, time of day, keywords, hashtags, etc.), though they are easy enough to include in the post title or body as you wish. With the `journaltools` package it becomes easy to manage large plaintext journals formatted as above, reorganizing and tidying the posts without modifying their content (except removing the redundant whitespace). The main operations are

1. `read_journal` from a plaintext file formatted as above,

2. `tidy_journal` to reorder the posts chronologically and remove redundant whitespace,

3. `filter_journal` either to includes or excludes posts based on a vector of keywords.

The `write_journal` function will export the resulting R object to file, but before that you can see what will be exported in the R environment. **(maybe make a prepare_journal function?)** To improve readibility, it will also space each post to have exactly three empty lines in-between. The package has checks to ensure no post is completely empty, that the dates are legitimate, and to warn about duplicate post titles.

Let's say I wanted to organize a collection of posts in a file called `research_notes.txt` in R's working directory, and isolate those that include the strings "reproducibil" or "replicat". The commands would be:

```

library(journaltools)

raw_text <- read_journal("./research_notes.txt")

cleaned_text <- sort_journal(raw_text)

write_journal(cleaned_text, "./tidy_research_notes.txt")

some_posts <- filter_journal(cleaned_text, includes = c("reproducibil", "replicat"), post.body=TRUE)

write_journal(some_posts, "reproducibility_posts.txt")

```

By default, only the contents of the post titles will be searched by `filter_journal`, but the `post.body` option will prompt `filter_journal` to look in the post body as well.

That's pretty much how it works. I've been using this plaintext journaling format for almost 20 years, and wrote this package to help me keep using this system basically forever.
