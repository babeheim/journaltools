
read_journal <- function( path ){
  raw <- readLines(path, warn = FALSE)
  # do I need to worry about nonprinting characters?
  title_elements <- grep("^\\d\\d\\d\\d-\\d\\d-\\d\\d - ", raw)
  post_lengths <- diff(title_elements)
  empty_posts <- which(post_lengths == 1)
  if (length(empty_posts) > 0){
    stop( paste("posts must contain at least one line of content,
     even if it's blank", raw[title_elements[empty_posts]], collapse = "\n") )
  }
  # note: this doesn't check whether the *last* post
  # has any content does it? meh
  n_posts <- length(title_elements)
  post_starts <- title_elements + 1
  post_ends <- c(title_elements[2:length(title_elements)] - 1, length(raw))
  output <- list(titles = character(), posts = list())
  # a fascinating bug: unless "posts" is properly typed, passing in scalars
  # creates the wrong type, and it won't accept vectors!
  output$titles <- raw[title_elements]
  for (i in 1:n_posts) output$posts[[i]] <- raw[post_starts[i]:post_ends[i]]
  if (title_elements[1] > 1){
    header <- raw[1:(title_elements[1] - 1)]
    header <- gsub("\\s", "", header)
    if (!all(header == "")){
      warning("some content exists in the file before the first title,
       fix this or lose it!")
    }
  }
  date_strings <- substr(output$titles, 1, 10)
  bad_dates <- which(is.na(as.Date(date_strings)))
  if (length(bad_dates) > 0){
    warning(paste0(c("these posts have bad dates, and may not sort properly",
     output$titles[bad_dates]), collapse = "\n"))
  }
  dups <- unique(output$titles[duplicated(output$titles)])
  if (length(dups) > 0){
    warning(paste0(c("these post titles are exact duplicates,
     proceed with caution", dups), collapse = "\n" ))
  }
  return(output)
}
