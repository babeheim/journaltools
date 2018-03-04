

# characters to screen out:
#  
# "\v" should be dropped...its producing weird results 


tidy_journal <- function( journal ){

  if( !all(names(journal) %in% c("titles", "posts")) ){
    stop("this is not a valid journal object; needs titles and posts objects")
  }

  if( length(journal$titles) != length(journal$posts) ){
    stop("this is not a valid journal object; titles and posts not same length")
  }

  # scrub nonprinting characters
  ## oh, what happens if the line contains things that R operates on? \ \ n?

  # convert all whitespace lines of any length to newlines

  for(i in 1:length(journal$posts)){
    journal$posts[[i]] <- gsub("^ *$", "", journal$posts[[i]])
  }

  # drop all newlines that appear immediately after another newline

  for(i in 1:length(journal$posts)){
    newlines <- grep("^$", journal$posts[[i]])
    duplicated_newlines <- newlines[which((newlines-1) %in% newlines)]
    if(length(duplicated_newlines) > 0) journal$posts[[i]] <- journal$posts[[i]][-duplicated_newlines]
  }

  # ensure that the last three elements of each post are newlines...no, do that in the write_journal function
  # also that the first element of a post is a newline too

  # organize posts and titles chronologically by date

  post_reorder <- rev(order(as.Date(substr(journal$titles, 1, 10))))

  journal$titles <- journal$titles[post_reorder]
  journal$posts <- journal$posts[post_reorder]

  return(journal)

}
