#' Wordcloud
#' Scott Cohn
#' Oct 18 // Dec 15


# Libraries ---------------------------------------------------------------

## libs needed
packages = c("tidyverse", 
             "tokenizers",
             "tm", 
             "SnowballC")

## Now load or install&load all
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

# Pre-Run -----------------------------------------------------------------

# Clear out existing files 
# Run one line at a time

# Delete the txt files from /bh_txts
system("rm bh_txts/*.txt")
system("rm bh_txts_clean/*.txt")
system("rm bh_wordlist/*.csv")

# File Mgmt ---------------------------------------------------------------

# Folder with PDFs
pdf_path <- "bh_pdfs"
txt_path <- "bh_txts"

# Make a vector of PDF file names
my_pdfs <- list.files(path = pdf_path, pattern = "pdf",  full.names = TRUE)

# Convert each PDF file that is named in the vector into a text file 
lapply(my_pdfs, function(i) system(paste('"pdftotext"', 
                                         paste0('"', i, '"')), wait = FALSE) )


# Run one line at a time
# Copy the txt files from /bh_pdf to /bh_txt
system("cp bh_pdfs/*.txt bh_txts")

# Delete the txt files from /bh_pdf
system("rm bh_pdfs/*.txt")

# Make a vector of txt file names
my_txts <- list.files(path = txt_path, pattern = "txt",  full.names = TRUE)
print(my_txts) # check

# Functions ---------------------------------------------------------------

# Import cleaning function
source("bh_cleantext.R")
# Import analysis function
source("bh_text_analysis.R")

# Stop words + Completion dict --------------------------------------------------------------

# import wordstop supplement
wordstop <- read.csv("wordstop.csv", header = FALSE)$V1
# append common english stopwords
wordstop <- c(wordstop, stopwords("en"))
# word completion for stemmings
# compdict <- read.csv("compdict.csv", header = FALSE)$V1


# Clean + Analyze Text ----------------------------------------------------

ch01 <- clean_text(my_txts[1], words_to_remove = wordstop)
text_analyze(ch01, "ch01", list_return = TRUE)

ch02 <- clean_text(my_txts[2], words_to_remove = wordstop)
text_analyze(ch02, "ch02", list_return = TRUE)

ch03 <- clean_text(my_txts[3], words_to_remove = wordstop)
text_analyze(ch03, "ch03", list_return = TRUE)

ch04 <- clean_text(my_txts[4], words_to_remove = wordstop)
text_analyze(ch04, "ch04", list_return = TRUE)

ch05 <- clean_text(my_txts[5], words_to_remove = wordstop)
text_analyze(ch05, "ch05", list_return = TRUE)

ch06 <- clean_text(my_txts[6], words_to_remove = wordstop)
text_analyze(ch06, "ch06", list_return = TRUE)

ch07 <- clean_text(my_txts[7], words_to_remove = wordstop)
text_analyze(ch07, "ch07", list_return = TRUE)

ch08 <- clean_text(my_txts[8], words_to_remove = wordstop)
text_analyze(ch08, "ch08", list_return = TRUE)

ch09 <- clean_text(my_txts[9], words_to_remove = wordstop)
text_analyze(ch09, "ch09", list_return = TRUE)

ch10 <- clean_text(my_txts[10], words_to_remove = wordstop)
text_analyze(ch10, "ch10", list_return = TRUE)

ch11 <- clean_text(my_txts[11], words_to_remove = wordstop)
text_analyze(ch11, "ch11", list_return = TRUE)

ch12 <- clean_text(my_txts[12], words_to_remove = wordstop)
text_analyze(ch12, "ch12", list_return = TRUE)

ch13 <- clean_text(my_txts[13], words_to_remove = wordstop)
text_analyze(ch13, "ch13", list_return = TRUE)

ch14 <- clean_text(my_txts[14], words_to_remove = wordstop)
text_analyze(ch14, "ch14", list_return = TRUE)

ch15 <- clean_text(my_txts[15], words_to_remove = wordstop)
text_analyze(ch15, "ch15", list_return = TRUE)

ch16 <- clean_text(my_txts[16], words_to_remove = wordstop)
text_analyze(ch16, "ch16", list_return = TRUE)
