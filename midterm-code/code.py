# Midterm code 

import numpy as np

from scipy import linalg

import constants as c
import helpers as h

def main():
  if c.run_a1:
    a1()

  # if c.run_a2:
  #   a2()


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
  main()

