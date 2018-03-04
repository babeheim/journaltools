
# characters to screen out:
#  
# "\v" should be dropped...its producing weird results 
# watch out for: posts that have body but no title yet....I guess just exclude those! 

library(testthat)

path <- "./tests/basic/basic_journal.txt"

doc <- load_journal(path)

test_that("basic works", {
  expect_true(identical(names(doc), c("titles", "posts")))
  expect_true(length(doc$titles)==3)
  expect_true(length(doc$posts)==3)
})



