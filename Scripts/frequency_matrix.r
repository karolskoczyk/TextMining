#zaladowanie bibliotek
library(tm)
library(stringr)

#zmiana katalogu roboczego
workDir <- "D:\\KS\\TextMining"
setwd(workDir)

#definicja katalogow funkcjonalnych
inputDir <- ".\\Data" #".\\Data" -> inputDir to to samo
outputDir <- ".\\Results"
scriptDir <- ".\\Scripts"
workspacesDir <- ".\\Workspaces"
dir.create(outputDir, showWarnings = FALSE)
dir.create(workspacesDir, showWarnings = FALSE)

#utworzenie korpusu dokumentow
corpusDir <- paste(
  inputDir, 
  "Literatura - streszczenia - przetworzone",
  sep = "\\"
)
corpus <- VCorpus(
  DirSource(
    corpusDir,
    pattern = "*.txt",
    encoding = "UTF-8"
  ),
  readerControl = list(
    language = "pl_PL"
  )
)

#usuniecie rozszerzen z nazw plikow w korpusie
cutExtensions <- function(document){
  meta(document, "id") <- gsub(pattern = "\\.txt$", replacement = "", meta(document, "id"))
  return(document)
}
corpus <- tm_map(corpus, cutExtensions)

#utworzenie macierzy czestosci
tdmTfAll <- TermDocumentMatrix(corpus)
dtmTfAll <- DocumentTermMatrix(corpus)
tdmBinAll <- TermDocumentMatrix(
  corpus,
  control = list(
    weighting = weightBin
  )
)

tdmTfidfAll <- TermDocumentMatrix(
  corpus,
  control = list(
    weighting = weightTfIdf
  )
)

tdmTfBounds <- TermDocumentMatrix(
  corpus,
  control = list(
    bounds = list(
      global = c(2,16)
    )
  )
)

tdmTfidfBounds <- TermDocumentMatrix(
  corpus,
  control = list(
    weighting = weightTfIdf,
    bounds = list(
      global = c(2,16)
    )
  )
)

dtmTfidfBounds <- DocumentTermMatrix(
  corpus,
  control = list(
    weighting = weightTfIdf,
    bounds = list(
      global = c(2,16)
    )
  )
)

dtmTfBounds <- DocumentTermMatrix(
  corpus,
  control = list(
    bounds = list(
      global = c(2,16)
    )
  )
)


#konwersja macierzy rzadkich do macierzy klasycznych

tdmTfAllMatrix <- as.matrix(tdmTfAll)
dtmTfAllMatrix <- as.matrix(dtmTfAll)
tdmBinAllMatrix <- as.matrix(tdmBinAll)
tdmTfidfAllMatrix <- as.matrix(tdmTfidfAll)
tdmTfBoundsMatrix <- as.matrix(tdmTfBounds)
tdmTfidfBoundsMatrix <- as.matrix(tdmTfidfBounds)
dtmTfidfBoundsMatrix <- as.matrix(dtmTfidfBounds)
dtmTfBoundsMatrix <- as.matrix(dtmTfBounds)

#eksport macierzy czestosci do pliku .csv
matrixFile <- paste (
  outputDir,
  "tdmTfidfBounds.csv",
  sep = "\\"
)
write.table(
  tdmTfidfBoundsMatrix,
  file = matrixFile,
  sep = ";",
  dec = ",",
  col.names = NA
)