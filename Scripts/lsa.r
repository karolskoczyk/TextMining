#zaladowanie bibliotek
library(lsa)

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

#analiza ukrytych wymiarow semantycznych (dekompozycja wg wartosci osobliwych)
lsa <- lsa(tdmTfidfBoundsMatrix)
lsa$tk #odpowiednik macierzy U, wspolrzedne wyrazow
lsa$dk #odpowiednik macierzy V, wspolrzedne dokumentow
lsa$sk #odpowiednik macierzy D, znaczenie skladowych 

#przygotowanie danych do wykresu
coordTerms <- lsa$tk%*%diag(lsa$sk)
coordDocs <- lsa$dk%*%diag(lsa$sk)
terms <- c("harry", "czarodziej", "dumbledore", "hermiona", "ron", "komnata", "powiedzieæ", "chcieæ", "dowiadywaæ", "albus", "syriusz", "lupin", "umbridge", "edmund", "kaspian", "³ucja", "czarownica", "piotr", "zuzanna", "aslana", "narnii", "baron", "dziecko", "wyspa", "bell", "edward", "wampir", "jacob")
termsImportance <- diag(lsa$tk%*%diag(lsa$sk)%*%t(diag(lsa$sk))%*%t(lsa$tk))
importantTerms <- names(tail(sort(termsImportance), 25))
coordTerms <- coordTerms[terms,]
#coordTerms <- coordTerms[importantTerms,]
legend <- paste(paste("d", 1:19, sep = ""), rownames(coordDocs), sep = "<=")
x1 <- coordDocs[,1]
y1 <- coordDocs[,2]
x2 <- coordTerms[,1]
y2 <- coordTerms[,2]

#wykres dokumentow i wybranych slow w przestrzeni dwuwymiarowej
options(scipen = 5)
plot(
  x1, 
  y1, 
  xlim = c(-0.2,0.05),
  #ylim = c(,),
  pch = 1,
  col = "orange"
)
points(
  x2, 
  y2, 
  pch = 2,
  col = "brown"
)
text(
  x1, 
  y1, 
  paste("d", 1:19, sep = ""),
  col = "orange",
  pos = 4
)
text(
  x2, 
  y2, 
  rownames(coordTerms),
  col = "brown",
  pos = 4
)
legend("bottomleft", legend, cex = 0.7, text.col = "orange")

#eksport wykresu do pliku .png
plotFile <- paste(
  outputDir,
  "lsa.png",
  sep = "\\"
)
png(file = plotFile)
options(scipen = 5)
plot(
  x1, 
  y1, 
  xlim = c(-0.2,0.05),
  #ylim = c(,),
  pch = 1,
  col = "orange"
)
points(
  x2, 
  y2, 
  pch = 2,
  col = "brown"
)
text(
  x1, 
  y1, 
  paste("d", 1:19, sep = ""),
  col = "orange",
  pos = 4
)
text(
  x2, 
  y2, 
  rownames(coordTerms),
  col = "brown",
  pos = 4
)
legend("bottomleft", legend, cex = 0.5, text.col = "orange")
dev.off()
