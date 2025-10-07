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
from plot_util import DiffSummary, save_plt_tight

tcs = [5, 6, 7]
lengths = [64, 100, 300, 500, 700, 900, 1100, 1300, 1500]

results = defaultdict(lambda: {})
for tc in tcs:
    for length in lengths:
        dirname = f'tc{tc}_sz{length:04d}'
        summary = DiffSummary()
        summary.read_file(f'results/{dirname}/diff_port2_summary.txt')
        results[tc][length] = summary


def plot(results, target_func, ylabel, filename):
    markers = {5: 'x', 6: '_', 7: '|'}

    for tc in results.keys():
        x = np.asarray([k for k in results[tc].keys()])
        y = np.asarray([target_func(v) for v in results[tc].values()])

        plt.plot(x, y, markers[tc], label=f'tc{tc}')

    plt.legend()
    plt.xlabel('frame size [Byte]')
    plt.ylabel(ylabel)
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


plot(results, lambda x: x.min_ts, 'Latency (min) [ns]', 'results/min_lat.png')
plot(results, lambda x: x.max_ts, 'Latency (max) [ns]', 'results/max_lat.png')
plot(results, lambda x: x.avg_ts, 'Latency (avg) [ns]', 'results/avg_lat.png')
plot(results, lambda x: x.std_ts, 'Latency (std) [ns]', 'results/std_lat.png')
