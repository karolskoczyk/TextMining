#zaladowanie bibliotek
library(topicmodels)

#zmiana katalogu roboczego
#workDir
workDir <- "D:\\KS\\TextMining"
setwd(workDir)

#definicja katalogu ze skryptami
sciptsDir <- ".\\Scripts"

#zaladowane skryptu
sourceFile <- paste(
  sciptsDir,
  "frequency_matrix.r",
  sep = "\\"
)
source(sourceFile)

#analiza ukrytej alokacji Dirichlet'a
nWords <- ncol(dtmTfAll)
nTopics <- 3
lda <- LDA(
  dtmTfAll, 
  k = nTopics, 
  method = "Gibbs",
  control = list(
    burnin = 2000,
    thin = 100,
    iter = 3000
  )
)
perplexity <- perplexity(lda, dtmTfAll)
results <- posterior(lda)

#prezentacja temat�w
par(mai = c(1,2,1,1))
topic1 <- head(sort(results$terms[1,], decreasing = TRUE), 20)
barplot(
  rev(topic1),
  horiz = TRUE,
  las = 1,
  main = "Temat 1",
  xlab = "Prawdopodobie�stwo",
  col = 'orange'
)
topic2 <- head(sort(results$terms[2,], decreasing = TRUE), 20)
barplot(
  rev(topic2),
  horiz = TRUE,
  las = 1,
  main = "Temat 2",
  xlab = "Prawdopodobie�stwo",
  col = 'turquoise'
)
topic3 <- head(sort(results$terms[3,], decreasing = TRUE), 20)
barplot(
  rev(topic3),
  horiz = TRUE,
  las = 1,
  main = "Temat 3",
  xlab = "Prawdopodobie�stwo",
  col = 'violet'
)

#prezentacja dokumentow 
document1 <- results$topics[1,]
barplot(
  rev(document1),
  horiz = TRUE,
  las = 1,
  main = rownames(results$topics)[1],
  xlab = "Prawdopodobie�stwo",
  col = 'orange'
)
document9 <- results$topics[9,]
barplot(
  rev(document9),
  horiz = TRUE,
  las = 1,
  main = rownames(results$topics)[9],
  xlab = "Prawdopodobie�stwo",
  col = 'turquoise'
)
document16 <- results$topics[16,]
barplot(
  rev(document16),
  horiz = TRUE,
  las = 1,
  main = rownames(results$topics)[16],
  xlab = "Prawdopodobie�stwo",
  col = 'violet'
)

#udzial tematow w slowach
words1 <- c("czarodziej", "czarownica", "wampir")
round(results$terms[,words1],2)

words2 <- c("harry", "�ucja", "bell")
round(results$terms[,words2],2)

#podzial dokumentow na skupienia na pdst dominujacych tematyk
