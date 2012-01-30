#!/usr/bin/Rscript

test <- function(num){
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
  
  cat(sprintf("%d,%.2f,%.2f,%.2f,%.2f,%.2f\n",num,T1,T2,T3,T4,sum(T1,T2,T3,T4)))
}

cat("Test,Initialize,Count Variance,Sort,Q10000,Total\n")
test(10)
test(9)
test(8)
test(7)
test(6)
test(5)
test(4)
test(3)
test(2)
test(1)

