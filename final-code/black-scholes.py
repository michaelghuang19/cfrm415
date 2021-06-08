import math
import numpy as np
from scipy.stats import norm

S = 3200
X = 3150
time = 0.063889
r = 0.01
sigma = 0.30

d_1 = (math.log(S / X) + ((r + 0.5 * (sigma ** 2)) * (time))) / (sigma * np.sqrt(time))
d_2 = d_1 - (sigma * np.sqrt(time))

put = (X * (math.e ** (-r * time)) * norm.cdf(-d_2)) - (S * norm.cdf(-d_1))

print("put")
print(put)

call = (S * norm.cdf(d_1)) - (X * (math.e ** (-r * time)) * norm.cdf(d_2))

print("call")
print(call)
