


validate_journal <- function(journal){
  if (!all(names(journal) %in% c("titles", "posts")) ){
    stop("this is not a valid journal object; needs titles and posts objects")
  }
  if (length(journal$titles) != length(journal$posts)){
    stop("this is not a valid journal object; titles and posts not same length")
  }
  my_dates <- as.Date(substr(journal$titles, 1, 10))
  if (any(is.na(my_dates))) stop("this is not a valid journal object;
   titles do not have true dates")
  return()
}

tidy_journal <- function(journal){
  validate_journal(journal)
  n_posts_og <- length(journal$titles)
  # convert all whitespace lines of any length to newlines
  for (i in 1:length(journal$posts)){
    journal$posts[[i]] <- gsub("^ *$", "", journal$posts[[i]])
  }
  # drop all newlines that appear immediately after another newline
  for (i in 1:length(journal$posts)){
    newlines <- grep("^$", journal$posts[[i]])
    duplicated_newlines <- newlines[which( (newlines - 1) %in% newlines)]
    if (length(duplicated_newlines) > 0){
      journal$posts[[i]] <- journal$posts[[i]][-duplicated_newlines]
    }
  }
  post_reorder <- rev(order(journal$titles))
  journal$titles <- journal$titles[post_reorder]
  journal$posts <- journal$posts[post_reorder]
  n_posts_tidy <- length(journal$titles)
  if (n_posts_og != n_posts_tidy) stop("post length is different
   after tidyfication")
  return(journal)
}
