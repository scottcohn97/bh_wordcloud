#' Clean text
#' Scott Cohn
#' Oct 18 // Dec 15

# Clean Text
clean_text <- function(file_name, words_to_remove, comp_dict = NULL, stem = TRUE){
  require(tidyverse, tm, SnowballC)
  
  # read file to txt
  ch_text <- readLines(file_name, warn = FALSE)
  
  # remove non UTF-8 char
  ch_text <- iconv(ch_text, 'utf-8', 'ascii', sub='')
  
  # create corpus
  docs <- Corpus(VectorSource(ch_text))

  # Text transform
  toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
  
  docs <- tm_map(docs, toSpace, "/")
  docs <- tm_map(docs, toSpace, "@")
  docs <- tm_map(docs, toSpace, "\\|")
  
  # Remove punctuations
  docs <- tm_map(docs, removePunctuation)
  
  # Remove numbers
  docs <- tm_map(docs, removeNumbers)
  
  # Convert the text to lower case
  docs <- tm_map(docs, content_transformer(tolower))
  
  # Remove stop words
  docs <- tm_map(docs, removeWords, words_to_remove)

  # Eliminate extra white spaces
  docs <- tm_map(docs, stripWhitespace)
  
  # Text stemming + completion
  if(stem == TRUE){
    docs <- tm_map(docs, content_transformer(stemDocument), language = "english")
    
    # add text stem completion
    # docs <- tm_map(docs, stemCompletion, comp_dict)
  }
  
  # returned cleaned text
  return(docs)
  
} # end function
