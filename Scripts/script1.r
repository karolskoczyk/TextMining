#zaladowanie bibliotek
library(tm)

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
corpusDir <- paste(inputDir, 
                   "Literatura - streszczenia - oryginał",
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

#wstepne przetwarzanie
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, content_transformer(tolower))
stoplistFile <- paste(inputDir, 
                      "stopwords_pl.txt",
                      sep = "\\"
)
stoplist <- readLines(stoplistFile, encoding = "UTF-8")
corpus <- tm_map(corpus, removeWords, stoplist)
corpus <- tm_map(corpus, stripWhitespace)

#wyswietlenie zawartosci korpusu
writeLines(as.character(corpus[[1]]))
writeLines(corpus[[1]]$content)
