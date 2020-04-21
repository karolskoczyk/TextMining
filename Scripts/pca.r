#zaladowanie bibliotek

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

#analiza glownych skladowych 
pca <- prcomp(dtmTfidfBounds)

#wykres dokumentow w przestrzeni dwuwymiarowej
legend <- paste(paste("d", 1:19, sep = ""), rownames(dtmTfidfBounds), sep = "<=")
options(scipen = 5)
plot(
  pca$x[,1], 
  pca$x[,2], 
  pch = 1,
  col = "orange"
  )
text(
  pca$x[,1], 
  pca$x[,2], 
  paste("d", 1:19, sep = ""),
  col = "orange",
  pos = 4
)
legend(0.01, 0,05, legend, text.font = 3, cex = 0.5, text.col = "orange")

#eksport wykresu do pliku .png
plotFile <- paste(
  outputDir,
  "pca.png",
  sep = "\\"
)
png(file = plotFile)
options(scipen = 5)
plot(
  pca$x[,1], 
  pca$x[,2], 
  #xlim = c(,),
  #ylim = c(,),
  pch = 1,
  col = "orange"
)
text(
  pca$x[,1], 
  pca$x[,2], 
  paste("d", 1:19, sep = ""),
  col = "orange",
  pos = 3
)
legend("bottomright", legend, text.font = 3, cex = 0.5, text.col = "orange")
dev.off()
