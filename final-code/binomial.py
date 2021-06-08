
import math
import numpy as np

up_p = 0.525
down_p = 1 - up_p
up = 1.152
down = 0.868
discount = math.e ** (-0.05 * 0.5)
s = 990
k = 1000

is_american = False

def main():
  price_tree = np.zeros((7, 4))
  payoff_tree = np.zeros((7, 4))

  rows, cols = price_tree.shape
  
  # initialize price
  price_tree[3][0] = s
  
  cur_ind_list = [3]
  for i in range(1, cols):
    for j in range(rows):
      if j - 1 >= 0 and price_tree[j - 1][i - 1] != 0:
        price_tree[j][i] = price_tree[j - 1][i - 1] * down
      if j + 1 <= rows - 1 and price_tree[j + 1][i - 1] != 0:
        price_tree[j][i] = price_tree[j + 1][i - 1] * up

  # initialize payoffs after pricing
  for i in np.arange(6, -1, -1):
    if price_tree[i][3] == 0:
      continue

    if price_tree[i][3] < k:
      payoff_tree[i][3] = k - price_tree[i][3]
    else:
      payoff_tree[i][3] = 0

  # start traversing backwards and replace accordingly
  for i in np.arange(cols - 2, -1, -1):
    for j in range(1, rows - 1):
      if price_tree[j + 1][i + 1] != 0 and price_tree[j - 1][i + 1] != 0:
        up_factor = payoff_tree[j - 1][i + 1] * up_p
        down_factor = payoff_tree[j + 1][i + 1] * down_p
        payoff_tree[j][i] = discount * (up_factor + down_factor)
      
      if is_american:
        # replace as necessary in american case
        if price_tree[j][i] != 0 and payoff_tree[j][i] < (k - price_tree[j][i]):
          payoff_tree[j][i] = k - price_tree[j][i]

  # formula: discount * ((u_p * up_val) + (d_p * down_val))

  print("price_tree")
  print(price_tree)
  print("payoff_tree")
  print(payoff_tree)
  

if __name__ == "__main__":
  main()
