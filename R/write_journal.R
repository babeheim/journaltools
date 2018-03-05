
write_journal <- function(journal, path){
  validate_journal(journal)
  # start the output file with two blank lines
  output <- c("", "")
  for (i in 1:length(journal$titles)){
    body <- journal$posts[[i]]
    # add a blank line before each post, if doesn't exist
    if (body[1] != "") body <- c("", body)
    # ensure each post ends with three blank lines
    if (body[length(body)] == ""){
      body <- c(body, "", "")
    } else {
      body <- c(body, "", "", "")
    }
    output <- c(output, c(journal$titles[i], body))
  }
  writeLines(output, path)
}
