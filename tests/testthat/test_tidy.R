

# also confirm that WINDOWS-FORMATTED text files work without corruptions! 

test_that("chronological ordering works", {
  path <- "./journals/basic_journal.txt"
  doc <- read_journal(path)
  expect_silent(x <- tidy_journal(doc))
  expect_false(identical(doc, x)) # false because of the reorder
  expect_true(length(x$titles)==3)
  expect_true(length(x$posts)==3)
  original_post_dates <- as.Date(substr(doc$titles, 1, 10))
  expect_false(all(diff(original_post_dates) <= 0)) # false because not in decreasing order
  corrected_post_dates <- as.Date(substr(x$titles, 1, 10))
  expect_true(all(diff(corrected_post_dates) <= 0))

  # multiple tidy-ings should not change output
  y <- tidy_journal(x)
  expect_true(identical(x,y))
  z <- tidy_journal(y)
  expect_true(identical(y,z))
  alpha <- tidy_journal(z)
  expect_true(identical(alpha,z))

})

test_that("corrupted files get caught", {
  path <- "./journals/basic_journal.txt"
  doc <- read_journal(path)
  doc <- doc$titles
  expect_error(x <- tidy_journal(doc))
  doc <- read_journal(path)
  doc$titles <- doc$titles[-1]
  expect_error(x <- tidy_journal(doc))

})


test_that("no-newline posts work fine", {

  path <- "./journals/no_newlines.txt"
  doc <- read_journal(path)
  expect_silent(x <- tidy_journal(doc))
  expect_false(identical(doc, x)) # false because of the reorder
  expect_true(length(x$titles)==3)
  expect_true(length(x$posts)==3)
  original_post_dates <- as.Date(substr(doc$titles, 1, 10))
  expect_false(all(diff(original_post_dates) <= 0)) # false because not in decreasing order
  corrected_post_dates <- as.Date(substr(x$titles, 1, 10))
  expect_true(all(diff(corrected_post_dates) <= 0))

  for(i in 1:length(x$posts)){
    newlines <- grep("^$", x$posts[[i]])
    duplicated_newlines <- newlines[which((newlines-1) %in% newlines)]
    expect_true(length(duplicated_newlines) == 0)
  }

  y <- tidy_journal(x)
  expect_true(identical(x,y))
  z <- tidy_journal(y)
  expect_true(identical(y,z))
  alpha <- tidy_journal(z)
  expect_true(identical(alpha,z))


})


test_that("extra newlines are removed", {

  path <- "./journals/extra_newlines.txt"
  doc <- read_journal(path)
  expect_silent(x <- tidy_journal(doc))
  expect_false(identical(doc, x)) # false because of the reorder
  expect_true(length(x$titles)==3)
  expect_true(length(x$posts)==3)
  original_post_dates <- as.Date(substr(doc$titles, 1, 10))
  expect_false(all(diff(original_post_dates) <= 0)) # false because not in decreasing order
  corrected_post_dates <- as.Date(substr(x$titles, 1, 10))
  expect_true(all(diff(corrected_post_dates) <= 0))

  for(i in 1:length(x$posts)){
    newlines <- grep("^$", x$posts[[i]])
    duplicated_newlines <- newlines[which((newlines-1) %in% newlines)]
    expect_true(length(duplicated_newlines) == 0)
  }

  y <- tidy_journal(x)
  expect_true(identical(x,y))
  z <- tidy_journal(y)
  expect_true(identical(y,z))
  alpha <- tidy_journal(z)
  expect_true(identical(alpha,z))

})


test_that("nonprinting characters are preserved", {

  path <- "./journals/nonprinting_characters.txt"
  doc <- read_journal(path)
  x <- tidy_journal(doc)
  expect_true(length(x$titles)==3)
  expect_true(length(x$posts)==3)


  y <- tidy_journal(x)
  expect_true(identical(x,y))
  z <- tidy_journal(y)
  expect_true(identical(y,z))
  alpha <- tidy_journal(z)
  expect_true(identical(alpha,z))


})



# confirm unusual Unicode characters are preserved

test_that("unusual unicode characters are preserved", {

  path <- "./journals/unusual_characters.txt"
  doc <- read_journal(path)

  x <- tidy_journal(doc)
  expect_true(length(grep("🔥", x$posts[[2]])) > 0)
  expect_true(length(grep("日本語", x$posts[[1]])) > 0)

  # multiple tidy-ings should not change output
  y <- tidy_journal(x)
  expect_true(identical(x,y))
  z <- tidy_journal(y)
  expect_true(identical(y,z))
  alpha <- tidy_journal(z)
  expect_true(identical(alpha,z))

})


