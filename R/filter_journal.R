
filter_journal <- function(journal, excludes = character(0),
 includes = character(0), post.body = FALSE){
  validate_journal(journal)
  if (length(excludes) > 0 & length(includes) > 0){
    stop("cannot use excludes and includes arguments at the same time")
  }
  output <- journal
  if (length(excludes) > 0){
    hits <- unlist(lapply(excludes, function(z) grep(z, journal$titles)))
    if (post.body == TRUE){
      body_hits <- unlist(lapply(excludes, function(z)
       which(unlist(regexpr(z, journal$posts)) > 0)))
      hits <- c(hits, body_hits)
    }
    hits <- sort(unique(hits))
    if (length(hits) == 0) stop("nothing found by these exclusion criteria")
    if (length(hits) == length(output$titles)) stop("this excludes everything")
    output$titles <- output$titles[-hits]
    output$posts <- output$posts[-hits]
  }
  if (length(includes) > 0){
    hits <- unlist(lapply(includes, function(z) grep(z, journal$titles)))
    if (post.body == TRUE){
      body_hits <- unlist(lapply(includes, function(z)
       which(unlist(regexpr(z, journal$posts)) > 0)))
      hits <- c(hits, body_hits)
    }
    hits <- sort(unique(hits))
    if (length(hits) == 0) stop("nothing found by these inclusion criteria")
    if (length(hits) == length(output$titles)) stop("this includes everything")
    output$titles <- output$titles[hits]
    output$posts <- output$posts[hits]
  }
  return(output)
}
