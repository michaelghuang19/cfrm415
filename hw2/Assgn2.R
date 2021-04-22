# Michael Huang
# CFRM 415
# Assignment 2 Code

library(lintr)
library(lubridate)
library(quadprog)

setwd("~/uw20.21/2021.4/cfrm415/cfrm-homework/cfrm415/hw2")

### Question 4 ###

# C
thirty_360_eur <- function(d1, d2) {
  
  day_diff = max(30 - day(d1), 0) + min(day(d2), 30)
  year_diff = 360 * (year(d2) - year(d1))
  month_diff = 30 * (month(d2) - month(d1) - 1)
  
  return ((day_diff + year_diff + month_diff) / 360)
}

solve_q4 <- function() {
  
  print("Sanity test example from lecture")
  print(thirty_360_eur(ymd(20000104), ymd(20000704)))
  # expected: 0.5
  
  print("4a.")
  d1 = ymd(20201015)
  d2 = ymd(20210415)
  print(thirty_360_eur(d1, d2))
  # output: 0.5
  
  print("4b.")
  d1 = ymd(20171026)
  d2 = ymd(20180820)
  print(thirty_360_eur(d1, d2))
  # output: 0.8166667
  
}

### Question 5 ###
solve_q5 <- function() {
  # a) Calculate the covariance matrix of the returns

  # b) Find the optimizing weights for the global minimizing variance portfolio.  Also, calculate the annualized return and volatility (remember that volatility is the square root of the variance)

  # c) Find the weights that minimize the portfolio variance for the case where the target monthly portfolio return is 1%.  Also, calculate the annualized volatility
  
}

solve_q4()
solve_q5()
