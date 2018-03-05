

test_that("all valid journals work", {

  path <- "./journals/basic_journal.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  out_path <- gsub("journals", "output", path)
  write_journal(tidy_doc, out_path)

  path <- "./journals/all_one_line_except_last.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  out_path <- gsub("journals", "output", path)
  write_journal(tidy_doc, out_path)

  path <- "./journals/extra_newlines.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  out_path <- gsub("journals", "output", path)
  write_journal(tidy_doc, out_path)

  path <- "./journals/no_newlines.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  out_path <- gsub("journals", "output", path)
  write_journal(tidy_doc, out_path)

  path <- "./journals/nonprinting_characters.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  out_path <- gsub("journals", "output", path)
  write_journal(tidy_doc, out_path)

  path <- "./journals/unusual_characters.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  out_path <- gsub("journals", "output", path)
  write_journal(tidy_doc, out_path)

  path <- "./journals/whitespace_posts.txt"
  doc <- read_journal(path)
  tidy_doc <- tidy_journal(doc)
  out_path <- gsub("journals", "output", path)
  write_journal(tidy_doc, out_path)

  path <- "./journals/dup_title.txt"
  expect_warning(doc <- read_journal(path))
  tidy_doc <- tidy_journal(doc)
  out_path <- gsub("journals", "output", path)
  write_journal(tidy_doc, out_path)

})


test_that("invalid journals don't work", {

  path <- "./journals/empty_post.txt"
  expect_error(doc <- read_journal(path))

  path <- "./journals/bad_date.txt"
  expect_warning(doc <- read_journal(path))
  expect_error(tidy_doc <- tidy_journal(doc))

})
