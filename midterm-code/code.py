# Midterm code 
# Run using
# python code.p [question number]

import numpy as np
import sys

from scipy import linalg

import constants as c
import helpers as h

def main(function_num):
  if (c.function_list[function_num - 1] != None):
    c.function_list[function_num - 1]()
  else:
    print("No such function")

def a1():
  print("a1")

  mu = c.a1_mu_T.T
  sigma = c.a1_sigma
  sigma_inv = linalg.inv(sigma)
  n, d = sigma.shape
  ones = np.ones((n, 1))

  omega_num = (sigma_inv).dot(ones)
  omega_den = (ones.T).dot(sigma_inv)
  omega_den = omega_den.dot(ones)
  omega = omega_num / omega_den

  returns = (omega.T).dot(mu)

  variance_denom = (ones.T).dot(sigma_inv).dot(ones)
  variance = 1 / (variance_denom)
  volatility = np.sqrt(variance)

  A = (ones.T).dot(sigma_inv).dot(ones)
  B = (mu.T).dot(sigma_inv).dot(ones)
  C = (mu.T).dot(sigma_inv).dot(mu)

  # part a responses
  print(omega)
  print(returns)
  print(volatility)
  # print(np.sqrt((omega.T).dot(sigma).dot(omega)))

def a5():
  print("a5")

  annual = c.a5_annual
  annual = sorted(annual)
  mean_annual = np.mean(annual)

  sigma = c.a5_monthly
  omega = c.a5_monthly_weights

  coeff = np.sqrt(12)
  Z = -1.64
  V = 1.5E6

  variance = (omega).dot(sigma).dot(omega.T)
  std = np.sqrt(variance)

  var = coeff * Z * std * V

  # part a responses
  print(annual)
  print(mean_annual)

  # part b responses
  print(variance)
  print(std)
  print(var)

if __name__ == "__main__":
  main(int(sys.argv[1]))

