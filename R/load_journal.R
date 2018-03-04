


load_journal <- function( path ){

  raw <- readLines(path, warn=FALSE)

  title_elements <- grep("^\\d\\d\\d\\d-\\d\\d-\\d\\d - ", raw)

  n_posts <- length(title_elements)
  post_starts <- title_elements + 1
  post_ends <- c(title_elements[2:length(title_elements)]-1, length(raw))

  output <- list()

  output$titles <- raw[title_elements]

  for(i in 1:n_posts) output$posts[[i]] <- raw[post_starts[i]:post_ends[i]]

  # warning: "the following dates are not valid, cannot sort properly"
  # warning: the following posts are duplicated, proceed with caution

  return(output)

}
