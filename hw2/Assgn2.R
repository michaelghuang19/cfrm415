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
  print("Sanity test example from lecture")
  print(thirty_360_eur(ymd(20000104), ymd(20000704)))
  # expected: 0.5
  
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

find_gmvp <- function() {

}

find_mvp <- function() {

}

solve_q5 <- function() {
  
  # load data
  data <- read.csv(paste(wd, "/", data_filename, ".csv", sep = ""))
  returns_data <- data[2:ncol(data)]
  
  print("5a")
  D <- cov(returns_data)
  print(D)
  D = 2 * D
  D
  
  # expected w
  ones = matrix(1, ncol(D))
  print((inv(D) %*% ones) / (t(ones) %*% inv(D) %*% ones)[[1]])
  
  # b) Find the optimizing weights for the global minimizing variance portfolio.  Also, calculate the annualized return and volatility (remember that volatility is the square root of the variance)
  
  print("5b")
  A <- matrix(data = 1, nrow = 1, ncol = nrow(D))
  means <- lapply(returns_data, mean)
  A <- rbind(A, means)

  # not sure if this is right
  b0 = c(1, 0)
  # b0 = c(1, 0)
  
  gmvp <- solve.QP(Dmat=D, dvec=rep(0, nrow(D)), Amat=t(A), bvec=b0, meq = 2)
  print(gmvp)
  
  # variance 1 / (1^T \sigma^-1 1)
  variance = 1 / (t(ones) %*% inv(D))[[1]]
  volatility = sqrt(variance)
  # annualized, so need to multiply the 4 months by 3?
  print(gmvp$value * 3)
  print(volatility * 3)
  
  
  # c) Find the weights that minimize the portfolio variance for the case where the target monthly portfolio return is 1%. Also, calculate the annualized volatility
  print("5c")
  
  

}

### "Main" ###

# solve_q4()
solve_q5()
