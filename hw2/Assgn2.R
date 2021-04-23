# Michael Huang
# CFRM 415
# Assignment 2 Code

library(lintr)
library(lubridate)
library(matlib)
library(quadprog)

### Constants ###

# COMMENT THIS IF YOU ARE NOT RUNNING THIS ON MICHAEL'S HOME COMPUTER
# and set the appropriate working directory instead
setwd("~/uw20.21/2021.4/cfrm415/cfrm-homework/cfrm415/hw2/")
wd <- getwd()

data_filename <- "returns_assgn2_415"


### Question 4 ###

thirty_360_eur <- function(d1, d2) {
  day_diff <- max(30 - day(d1), 0) + min(day(d2), 30)
  year_diff <- 360 * (year(d2) - year(d1))
  month_diff <- 30 * (month(d2) - month(d1) - 1)
  
  return ((day_diff + year_diff + month_diff) / 360)
}

solve_q4 <- function() {
  print("4a.")
  d1 <- ymd(20201015)
  d2 <- ymd(20210415)
  print(thirty_360_eur(d1, d2))
  # output: 0.5
  
  print("4b.")
  d1 <- ymd(20171026)
  d2 <- ymd(20180820)
  print(thirty_360_eur(d1, d2))
  # output: 0.8166667
}


### Question 5 ###

solve_q5 <- function() {
  
  # load data
  data <- read.csv(paste(wd, "/", data_filename, ".csv", sep = ""))
  returns_data <- data[2:ncol(data)]
  
  # a) Calculate the covariance matrix of the returns
  print("5a")
  
  D <- cov(returns_data)
  print(D)
  
  # b) Find the optimizing weights for the global minimizing variance portfolio.  Also, calculate the annualized return and volatility (remember that volatility is the square root of the variance)
  
  print("5b")
  
  means <- lapply(returns_data, mean)
  ones <- matrix(1, ncol(D))
  A <- matrix(data = 1, nrow = 1, ncol = nrow(D))
  b0 <- c(1)
  
  gmvp <- solve.QP(Dmat=D, dvec=rep(0, nrow(D)), Amat=t(A), bvec=b0, meq = 1)
  
  # variance 1 / (1^T \sigma^-1 1)
  returns <- t(as.matrix(unlist(means))) %*% as.matrix(unlist(gmvp$solution))
  variance <- 1 / (t(ones) %*% inv(D) %*% ones)[[1]]
  volatility <- sqrt(variance)
  # annualized, so need to multiply the 4 months by 3?
  print(paste("optimizing weights for gmvp: ", gmvp$solution))
  print(paste("annualized returns: ", returns * 3))
  print(paste("annualized volatility: ", volatility * 3))
  
  
  # c) Find the weights that minimize the portfolio variance for the case where the target monthly portfolio return is 1%. Also, calculate the annualized volatility
  print("5c")
    
  A <- rbind(A, means)
  # this is 1% across the 4 months, which is wrong
  b0 = c(1, 0.01)
  
  one_pct <- solve.QP(Dmat=D, dvec=rep(0, nrow(D)), Amat=t(A), bvec=b0, meq = 2)
  
  variance <- D %*% one_pct$solution
  print(variance)
  variance <- 1 / (t(ones) %*% inv(D) %*% ones)[[1]]
  print(variance)
  volatility <- sqrt(variance)
  # again annualized, so need to multiply the 4 months by 3?
  print(paste("weights for 1% target return: ", one_pct$solution))
  print(paste("annualized volatility: ", volatility * 3))
}

### "Main" ###

solve_q4()
solve_q5()
