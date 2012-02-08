#!/usr/bin/Rscript

test <- function(){
  s <- Sys.time()
  a <- sample(0:99,1E6,replace=T)
  e <- Sys.time()
  T1 <- as.numeric(e-s)
  s <- e
  sum <- sum(a)
  std <- sd(a)
  e <- Sys.time()
  T2 <- as.numeric(e-s)
  s <- e
  sorted <- sort(a)
  e <- Sys.time()
  T3 <- as.numeric(e-s)
  s <- e
  q <- quantile(sorted,seq(from = 0, to = 1, by=1/10000))
  e <- Sys.time()
  T4 <- as.numeric(e-s)
  
  return(c(T1,T2,T3,T4))
}

cat("Test,Initialize,Count Variance,Sort,Q10000,Total\n")
for(num in rev(1:10)) {
  RESULT <- test()
  cat(sprintf("%d,%s,%.3f\n",num,paste(sprintf("%.2f",RESULT), sep="",collapse=","),sum(RESULT)))
}
