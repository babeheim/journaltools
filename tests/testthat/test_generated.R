


id_maker <- function(n, reserved='', seed=NA, nchars=NA){
  my_let <- letters 
  my_num <- 0:9 
  if(is.na(seed) | !is.numeric(seed)) set.seed(as.numeric(as.POSIXlt(Sys.time())))
  if(!is.na(seed) & is.numeric(seed)) set.seed(seed)
  output <- replicate(n, paste(sample(c(my_let, my_num), nchars, replace=TRUE), 
      collapse=''))
  rejected <- duplicated(output) | output %in% reserved | substr(output, 1, 1) %in% my_num
  while(any(rejected)){
      output <- output[-which(rejected)]
      remaining <- n-length(output)
      output <- c(output, replicate(remaining, paste(sample(c(my_let, my_num), nchars, 
          replace=TRUE), collapse='')))
      rejected <- duplicated(output) | output %in% reserved | substr(output, 1, 1) %in% my_num
  }
  output
}

word_list <- c(
  "India",
  "Oscar",
  "Lima",
  "Juliet",
  "Zulu",
  "Sierra",
  "Tango"
)


test_that("big generated journal works", {

  n_posts <- 10000

  offsets <- sample(2:365, n_posts, replace=TRUE)

  anchor <- "2018-01-01"

  my_dates <- as.character(as.Date(anchor) + offsets)

  my_titles <- id_maker(n_posts, nchars=13)

  my_titles <- paste0(my_dates, " - ", my_titles)

  seeds <- sample(word_list, n_posts, replace=TRUE)

  posts <- lapply(seeds, function(z) rep(z, 30))

  doc <- list(titles = my_titles, posts = posts)

  x <- tidy_journal(doc)

  write_journal(x, "./generated/test.txt")

  y <- read_journal("./generated/test.txt")

  expect_true(identical(x$titles,y$titles))

  expect_true(length(y$titles) == n_posts)

  expect_true(all(unlist(lapply(y$posts, function(z) length(unique(z)))) == 2))

})
