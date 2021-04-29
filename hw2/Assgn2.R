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
  
  # load in monthly data
  data <- read.csv(paste(wd, "/", data_filename, ".csv", sep = ""))
  returns_data <- data[2:ncol(data)]
  
  # a) Calculate the covariance matrix of the returns
  print("5a")
  
  D <- cov(returns_data)
  
  print(D)
  
  # b) Find the optimizing weights for the global minimizing variance portfolio.  Also, calculate the annualized return and volatility (remember that volatility is the square root of the variance)
  print("5b")
  
  means <- lapply(returns_data, mean)
  mean_vector <- as.matrix(unlist(means))
  ones <- matrix(1, ncol(D))
  
  A <- matrix(data = 1, nrow = 1, ncol = nrow(D))
  b0 <- c(1)
  
  gmvp <- solve.QP(Dmat=D, dvec=rep(0, nrow(D)),
                   Amat=t(A), bvec=b0, meq = 1)
  
  # variance 1 / (1^T \sigma^-1 1)
  weight_vector <- as.matrix(unlist(gmvp$solution))
  returns <- t(mean_vector) %*% weight_vector
  variance <- t(weight_vector) %*% D %*% weight_vector
  
  print("optimizing weights for gmvp:")
  print(weight_vector)
  print(paste("annualized returns: ", returns * 12))
  print(paste("annualized volatility: ", sqrt(12 * variance)))
  
  # c) Find the weights that minimize the portfolio variance for the case where the target monthly portfolio return is 1%. Also, calculate the annualized volatility
  print("5c")
    
  A <- rbind(A, means)
  b0 = c(1, 0.01)
  
  one_pct <- solve.QP(Dmat=D, dvec=rep(0, nrow(D)),
                      Amat=t(A), bvec=b0, meq = 2)
  
  weight_vector <- as.matrix(unlist(one_pct$solution))
  returns <- t(mean_vector) %*% weight_vector
  variance <- t(weight_vector) %*% D %*% weight_vector
  
  print("weights for 1% target return:")
  print(weight_vector)
  print(paste("monthly returns sanity check: ", returns))
  print(paste("annualized volatility: ", sqrt(12 * variance)))
}

### "Main" ###

solve_q4()
solve_q5()
