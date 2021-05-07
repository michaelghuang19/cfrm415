# Michael Huang
# CFRM 415
# Midterm Code

library(lintr)
library(lubridate)
library(matlib)
library(quadprog)

thirty_360_eur <- function(d1, d2) {
  day_diff <- max(30 - day(d1), 0) + min(day(d2), 30)
  year_diff <- 360 * (year(d2) - year(d1))
  month_diff <- 30 * (month(d2) - month(d1) - 1)

  return((day_diff + year_diff + month_diff) / 360)
}

t0 <- ymd(20210506)
t1 <- ymd(20211104)
t2 <- ymd(20220506)

print(t1 - t0)
print((t1 - t0) / 360)
print(t2 - t1)
print((t2 - t1) / 360)
print(t2 - t0)
print((t2 - t0) / 360)

