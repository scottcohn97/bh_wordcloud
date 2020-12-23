#' Excel Aggregation
#' Scott Cohn
#' Dec 15

# Shamelessly stolen from
# https://stackoverflow.com/questions/25086676/save-different-csv-files-as-one-excel-workbook-with-multiple-sheets

library(data.table)  
library(XLConnect)

folder <- "bh_wordlist"

f.out <- "bh_wordlist/wordlist_master.xlsx"

## load in file
wb <- loadWorkbook(f.out, create=TRUE)

## get all files
pattern.ext <- "\\.csv$"
files <- dir(folder, full=TRUE, pattern=pattern.ext)

## Grab the base file names, you can use them as the sheet names
files.nms <- basename(files)
files.nms <- gsub(pattern.ext, "", files.nms)

## set the names to make them easier to grab
names(files) <- files.nms

for (nm in files.nms) {
  ## ingest the CSV file
  temp_DT <- fread(files[[nm]])
  
  ## Create the sheet where the file will be outputed to 
  createSheet(wb, name=nm)
  
  ## output the csv contents
  writeWorksheet(object=wb, data=temp_DT, sheet=nm, header=TRUE, rownames=NULL)
}

saveWorkbook(wb)
