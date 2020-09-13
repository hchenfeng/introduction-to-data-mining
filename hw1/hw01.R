iq <- rnorm(100, mean = 100, sd = 20)
iq + 10
mean(iq)
sd(iq)
iq[1:10]
iq[11:20]

matdata <- c(3, 7,-1, 6, 10, 0)
tmp <- matrix(matdata,
              nrow = 2,
              ncol = 3,
              byrow = TRUE)
x <- read.table("data.txt", header = TRUE)
mean(x[, 3])
sum(x[5:15, 2])
ind <- x[, 3] > 90000
mean(x[ind, 2])

idx <- x[, 4] < 700
mean(x[idx, 3])

fmean <- 0
fcounter <- 0
ftotal <- 0
for (i in 1:nrow(x)) {
  if (x[i, 4] < 700) {
    ftotal <- ftotal + x[i, 3]
    fcounter <- fcounter + 1
  }
}
fmean <- ftotal / fcounter

meanValuesOfColumns = function(tableName) {
  tableData <- read.table(tableName, header = TRUE)
  mean2 <- mean(tableData[, 2])
  mean3 <- mean(tableData[, 3])
  mean4 <- mean(tableData[, 4])
  meanValuesOfColumns <- c(mean2, mean3, mean4)
  return (meanValuesOfColumns)
}
