

test_that("filters have to be good", {

  path <- "./journals/basic_journal.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  
  expect_error(filter_journal(tidy_doc, includes = "test", excludes = "blah"))

})


test_that("excludes works on titles", {

  path <- "./journals/basic_journal.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  
  filt1 <- filter_journal(tidy_doc, excludes = "#hash1")
  expect_true(length(filt1$titles) == 1)

  filt2 <- filter_journal(tidy_doc, excludes = "#hash2")
  expect_true(length(filt2$titles) == 2)

})

test_that("includes works on titles", {

  path <- "./journals/basic_journal.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  
  filt1 <- filter_journal(tidy_doc, includes = "#hash1")
  expect_true(length(filt1$titles) == 2)

  filt2 <- filter_journal(tidy_doc, includes = "#hash2")
  expect_true(length(filt2$titles) == 1)
  
})


test_that("excludes works on everything", {

  path <- "./journals/basic_journal.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  
  filt1 <- filter_journal(tidy_doc, excludes = "three", post.body=TRUE)
  expect_true(length(filt1$titles) == 2)

  filt2 <- filter_journal(tidy_doc, excludes = c("#hash2", "content"), post.body=TRUE)
  expect_true(length(filt2$titles) == 1)

})


test_that("includes works on everything", {

  path <- "./journals/basic_journal.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  
  filt1 <- filter_journal(tidy_doc, includes = "three", post.body=TRUE)
  expect_true(length(filt1$titles) == 1)

  filt2 <- filter_journal(tidy_doc, includes = c("#hash2", "content"), post.body=TRUE)
  expect_true(length(filt2$titles) == 2)

})

test_that("includes/excludes returns an error if pattern not found", {

  path <- "./journals/basic_journal.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  
  expect_error(filt <- filter_journal(tidy_doc, excludes = "#notthere"))
  expect_error(filt <- filter_journal(tidy_doc, includes = "#notthere"))

})

test_that("includes/excludes returns an error if every post is matched", {

  path <- "./journals/basic_journal.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  
  expect_error(filt <- filter_journal(tidy_doc, excludes = "-"))
  expect_error(filt <- filter_journal(tidy_doc, includes = "-"))

  expect_error(filt <- filter_journal(tidy_doc, excludes = "-", post.body=TRUE))
  expect_error(filt <- filter_journal(tidy_doc, includes = "-", post.body=TRUE))

  expect_error(filt <- filter_journal(tidy_doc, includes = ""))
  expect_error(filt <- filter_journal(tidy_doc, includes = " "))
  expect_error(filt <- filter_journal(tidy_doc, includes = "", post.body=TRUE))
  expect_error(filt <- filter_journal(tidy_doc, includes = " ", post.body=TRUE))

  expect_error(filt <- filter_journal(tidy_doc, excludes = ""))
  expect_error(filt <- filter_journal(tidy_doc, excludes = " "))
  expect_error(filt <- filter_journal(tidy_doc, excludes = "", post.body=TRUE))
  expect_error(filt <- filter_journal(tidy_doc, excludes = " ", post.body=TRUE))

})