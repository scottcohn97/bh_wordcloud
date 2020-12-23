#' Wordcloud - Analyze
#' Scott Cohn
#' Oct 19 // Dec 15

# Text analysis
text_analyze <- function(chapter_name,               # Corpus
                         chapter_name_str,           # String for filename
                         words_to_remove = wordstop, # Stop words
                         list_return = FALSE){       # Return csv of words/freq
  require(tokenizers)
  
  # find n-grams list
  generate_ngrams <- function(df, n_val){
    df <- unlist(df)
    ngram_list <- vector(mode = "character")
    for (i in 1:length(df)) {
      this_ngram_list <- tokenize_ngrams(
        df[i], n = n_val, simplify = FALSE)
      ngram_list <- c(ngram_list, this_ngram_list[[1]])
    }
    return(ngram_list)
  }
  
  # n-grams df
  generate_ngrams_df <- function(corpus, n_val){
    df <- data.frame(text = sapply(corpus, as.character), stringsAsFactors = FALSE)
    ngram_list <- unname(unlist(sapply(df, generate_ngrams, n_val)))
    ngram_df <- data.frame(table(ngram_list))
    # find perc
    ngram_df$percentage <- (ngram_df$Freq/sum(ngram_df$Freq))
    # order by freq
    ngram_df <- ngram_df[order(-ngram_df$Freq),]
    # colnames
    colnames(ngram_df) <- c("words","freq","percentage")
    # recast as char
    ngram_df$words <- as.character(ngram_df$words)
    # remove single char pairings
    ngram_df <- ngram_df %>% filter(nchar(words) > 3)
    # return df
    return(ngram_df)
  }
  
  # plot n-grams
  # plot_ngram <- function(df, n_val, title){
  #   df <- df[1:n_val,]
  #   df$words <- reorder(df$words, df$freq)
  #   p <- ggplot(df, aes(x = words, y = freq)) +
  #     geom_bar(stat = "identity", fill = "#377EB8") +
  #     ggtitle(title) +
  #     coord_flip() +
  #     theme(legend.position = "none") + 
  #     theme_bw()
  #   return(p)
  # }
  
  # chapter_name <- ch01  # cleaned text
  # chapter_name_str <-"ch01" # name
  
  #### Build a term-document matrix
  dtm <- TermDocumentMatrix(chapter_name)
  m <- as.matrix(dtm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)
  rownames(d) <- NULL
  
  d <- d %>% 
    # take top 200
    slice(1:200)
  
  chapter_name_corpus <- Corpus(VectorSource(chapter_name))
  
  # create list of bigrams
  bigrams <- generate_ngrams_df(chapter_name_corpus, 2) %>% 
    # chose top 10
    slice(1:10) %>% 
    # separate into two cols
    separate(words, c("word1", "word2"), sep = " ") %>% 
    # tilde between words
    mutate(bigram = paste0(word1, "~", word2))
  

  # for each word in bigram column 1
  for (i in bigrams$word1) {
    # if word matches in full list
    if(i %in% d$word == TRUE){
      # capture index of matched word
      index <- match(i, d$word)
      index_b <- match(i, bigrams$word1)
      # substract freq by # of bigram occur
      d$freq[index] = d$freq[index] - bigrams$freq[index_b]
    }
  }
  
  # repeat for bigram col 2
  for (i in bigrams$word2) {
    # if word matches in full list
    if(i %in% d$word == TRUE){
      # capture index of matched word
      index <- match(i, d$word)
      index_b <- match(i, bigrams$word2)
      # substract freq by # of bigram occur
      d$freq[index] = d$freq[index] - bigrams$freq[index_b]
    }
  }
  
  # append to d
  bigram_to_append <- bigrams %>% 
    select(bigram, freq) %>% 
    rename(word = bigram)
  
  words_list <- union(d, bigram_to_append) 
  
  # sort by freq
  words_list <- words_list %>% 
    # double check words being removed
    filter(!word %in% words_to_remove) %>% 
    arrange(-freq) %>% 
    slice(1:150)
  
  # write to list
  word_cloud_list <- list()
  
  for (i in 1:nrow(words_list)){
    memo_list <- rep.int(x = words_list$word[i], times = words_list$freq[i])
    
    word_cloud_list <- append(word_cloud_list, list(memo_list))
  }
  
  # check # of uniques (should be length of list)
  length(unique(word_cloud_list))
  
  # save as txt
  lapply(word_cloud_list, write, paste0("bh_txts_clean/",chapter_name_str, "_wordle.txt"), append=TRUE)
  
  if (list_return == TRUE) {
    #return(words_list)
    write_csv(words_list, paste0("bh_wordlist/", chapter_name_str, "_wordslist.csv"))
  }
} # end function

