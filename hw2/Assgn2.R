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
  
  
}

solve_q4 <- function() {
  # a) d1 = 2020.10.15, d2 = 2021.04.15
  # b) d1 = 2017.10.26, d2 = 2018.08.20 
  
  # Use the ymd(.) lubridate function to create the lubridate objects
  # ymd(20210401) returns a lubridate object representing the date 2021.04.01.  Also, the year, month, and day in each lubridate object obj can be accessed with the functions year(obj), month(obj), and day(obj) respectively.  
}

### Question 5 ###
solve_q5 <- function() {
  # a) Calculate the covariance matrix of the returns

  # b) Find the optimizing weights for the global minimizing variance portfolio.  Also, calculate the annualized return and volatility (remember that volatility is the square root of the variance)

  # c) Find the weights that minimize the portfolio variance for the case where the target monthly portfolio return is 1%.  Also, calculate the annualized volatility
  
}
