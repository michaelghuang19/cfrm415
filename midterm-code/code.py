# Midterm code 

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

  # variance < - t(weight_vector) % * % D % * % weight_vector

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

  

if __name__ == "__main__":
  main(int(sys.argv[1]))

