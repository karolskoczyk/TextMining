#zaladowanie bibliotek
library(wordcloud)
library(slowraker)

#zmiana katalogu roboczego
#workDir
workDir <- "D:\\KS\\TextMining"
setwd(workDir)

#definicja katalogu ze skryptami
sciptsDir <- ".\\Scripts"

#zaladowane skryptu
sourceFile <- paste(
  sciptsDir,
  "lda.r",
  sep = "\\"
)
source(sourceFile)

#dla pierwszego dokumentu
## wagi tf jako miara waznosci slow
keywordsTf1 <- head(sort(dtmTfAllMatrix[1,], decreasing = TRUE))
keywordsTf1
##wagi tfidf jako miara waznosci slow
keywordsTfidf1 <- head(sort(dtmTfidfBoundsMatrix[1,], decreasing = TRUE))
keywordsTfidf1
##lda jako miara waznosci slow
importance1 <- c(results$topics[1,]%*%results$terms)
names(importance1) <- colnames(results$terms)
keywordsLda1 <- head(sort(importance1, decreasing = TRUE))
keywordsLda1
##chmura tagow
par(mai = c(0,0,0,0))
wordcloud(corpus[1], max.words = 200, colors = brewer.pal(8, "PuOr"))
##algorytm RAKE
text1 <- as.character(corpus[1])
rake1 <- slowrake(txt = text1, stem = FALSE, stop_pos = NULL)
print(rake1[[1]])
