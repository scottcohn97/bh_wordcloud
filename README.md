# Bowles-Halliday Word Clouds

## Scott Cohn

This project takes a folder of PDFs (`\bh_pdfs`), one per textbook chapter, converts the files to a `.txt` files and places the `.txt` file in a new folder (`\bh_txts`). A cleaning function parses the text and finds the most frequent words and n-grams and compiles them into a list of top-X words. This list is ported to an external application, Wordl, to create a word cloud.

This is an extension of the forthcoming microeconomics text found [here](http://simondhalliday.com/microeconomics/).

Here is an example:

<img src="bh_clouds/cloud_01.png"
     alt="ch01"
     style="float: left; margin-right: 10px;" />

The only file that needs to be run is the `bh_wordcloud` file. 

### REQUIREMENTS:
Install: https://www.xpdfreader.com/download.html 
and copy the executables (xpdf, pdftotext, etc.) to to /usr/local/bin.
Use bash script: sudo cp Applications/xpdf/bin64/pdftotext /usr/local/bin

### DIRECTORY:

```
  +-- README.md
  +-- bh_wordcloud.RProj
  +-- bh_cleantext.R
  +-- bh_text_analysis.R
  +-- bh_wordcloud.R 
  +-- excel_aggregation.R
  +-- wordstop.csv
  +-- compdict.csv
  +-- _bh_pdfs
  |   +-- BHMicro_chxx.pdf
  |   +-- BHMicro_chxx.pdf
  +-- _bh_txts
  |   +-- BHMicro_chxx.txt
  |   +-- BHMicro_chxx.txt
  +-- _bh_txts_clean
  |   +-- chxx_wordle.txt
  |   +-- chxx_wordle.txt
  +-- _bh_wordlist
  |   +-- wordlist_master.xlsx
  |   +-- chxx_wordlist.csv
  |   +-- chxx_wordlist.csv
```
