

test_that("basic works", {
  path <- "./journals/basic_journal.txt"
  doc <- load_journal(path)
  expect_true(identical(names(doc), c("titles", "posts")))
  expect_true(length(doc$titles)==3)
  expect_true(length(doc$posts)==3)
})

test_that("unusual ones work", {
  path <- "./journals/extra_newlines.txt"
  doc <- load_journal(path)
  expect_true(identical(names(doc), c("titles", "posts")))
  expect_true(length(doc$titles)==3)
  expect_true(length(doc$posts)==3)
  path <- "./journals/no_newlines.txt"
  doc <- load_journal(path)
  expect_true(identical(names(doc), c("titles", "posts")))
  expect_true(length(doc$titles)==3)
  expect_true(length(doc$posts)==3)
})

test_that("bad_date prints warning", {
  path <- "./journals/bad_date.txt"
  expect_warning(doc <- load_journal(path))
})

test_that("duplicated title prints warning", {
  path <- "./journals/dup_title.txt"
  expect_warning(doc <- load_journal(path))
})

test_that("whitespace posts have no problems", {
  path <- "./journals/whitespace_posts.txt"
  expect_silent(doc <- load_journal(path))
  expect_true(identical(names(doc), c("titles", "posts")))
  expect_true(length(doc$titles)==4)
  expect_true(length(doc$posts)==4)
})

test_that("an empty post returns an error", {
  path <- "./journals/empty_post.txt"
  expect_error(doc <- load_journal(path))
})
