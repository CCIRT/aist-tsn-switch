# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import csv
from collections import defaultdict
import matplotlib.pyplot as plt
import numpy as np
import sys

sys.path.append('../common_script')
from plot_util import save_plt_tight

tcs = [5, 6, 7]
lengths = [64, 1500]

results = {}
for tc in tcs:
    for length in lengths:
        dirname = f'tc{tc}_sz{length:04d}'
        with open(f'results/{dirname}/diff_port2.csv', 'r') as f:
            reader = csv.DictReader(f)
            results[dirname] = []
            for row in reader:
                results[dirname].append(int(row['timestamp_val']))

def plot(result, name):
    counts = defaultdict(lambda: 0)

    for r in result:
        # cycle to nanoseconds
        r *= 8
        counts[r] += 1

    plt.plot(counts.keys(), counts.values(), 'o', label=name)

for k, v in results.items():
    plot(v, k)

plt.xticks([0, 8])
plt.xlim([-2, 10])
plt.legend()
plt.xlabel('latency [ns]')
plt.ylabel('The number of frames')
save_plt_tight('results/latency.png')
