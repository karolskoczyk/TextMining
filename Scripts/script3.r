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
  "script2.r",
  sep = "\\"
)
source(sourceFile)

#skalowanie wielowymiarowe (MDS)
distCos <- dist(dtmTfidfBoundsMatrix, method = "cosine")
distCosMatrix <- as.matrix(distCos)
mds <- cmdscale(distCos, eig = TRUE, k=2)
x <- mds$points[,1]
y <- mds$points[,2]
plot(
  x,
  y,
  xlab = "Synthetic variable 1",
  ylab = "Synthetic variable 2",
  main = "Multidimensional Scalling"
)
text(
  x,
  y,
  labels = row.names(distCosMatrix),
  cex = .7
)

#eksport wykresu do pliku .png
plotFile <- paste(
  outputDir,
  "mds.png",
  sep = "\\"
)
png(file = plotFile)
plot(
  x,
  y,
  xlab = "Synthetic variable 1",
  ylab = "Synthetic variable 2",
  main = "Multidimensional Scalling",
  col = "orange",
  xlim = c(-0.5, 0.5)
)
text(
  x,
  y,
  labels = row.names(distCosMatrix),
  cex = .7,
  col = "orange"
)
dev.off()