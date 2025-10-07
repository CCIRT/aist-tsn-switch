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
from plot_util import DiffSummary, TimestampSummary, save_plt_tight


def plot_latency_bar(results, filename):
    x = np.arange(len(results), dtype=np.float64)
    y_min = [v.min_ts for v in results.values()]
    y_avg = [v.avg_ts for v in results.values()]
    y_max = [v.max_ts for v in results.values()]

    width = 0.2
    interval = 0.05

    plt.bar(x, y_min, width=width, label='min')
    x += width + interval
    plt.bar(x, y_avg, width=width, label='avg')
    x += width + interval
    plt.bar(x, y_max, width=width, label='max')
    x -= width + interval

    plt.legend()
    plt.title('Latency of TC7: min, avg, max')
    plt.ylabel('Latency [ns]')
    plt.xlabel('TC5 rate [Mbps]')
    plt.xticks(x, list(results.keys()))
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


def plot_latency_hist(results_ts, freq_mhz, filename):
    width = 0.1
    interval = 0

    ns_per_cycle = 1000 / freq_mhz

    x = []
    labels = []
    for key, val in results_ts.items():
        x.append([v * ns_per_cycle for v in val.timestamp_val])
        labels.append(f'tc5_{key}')
    plt.hist(x, label=labels)
    plt.legend()
    plt.ylabel('Counts')
    plt.ylabel('Latency [ns]')
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


def plot_latency_points(timestamp_lats: TimestampSummary, freq_mhz, filename):
    us_per_cycle = 1 / freq_mhz
    y = np.array(timestamp_lats.timestamp_val) * us_per_cycle
    x = np.arange(len(y))

    minval = np.amin(y)
    avgval = np.average(y)
    p25 = np.percentile(y, 25)
    p50 = np.percentile(y, 50)
    p75 = np.percentile(y, 75)
    maxval = np.amax(y)

    plt.hlines(minval, x[0], x[-1], 'C1', label='min')
    plt.hlines(p25, x[0], x[-1], 'C2', label='25%')
    plt.hlines(p50, x[0], x[-1], 'C3', label='50%')
    plt.hlines(p75, x[0], x[-1], 'C4', label='75%')
    plt.hlines(maxval, x[0], x[-1], 'C5', label='max')
    plt.hlines(avgval, x[0], x[-1], 'C6', label='ave')
    plt.plot(x, y, 'o', markersize=1, label='each frame')

    print(f'min: {minval}, max: {maxval}, avg: {avgval}, 25%: {p25}, 50%: {p50}, 75%: {p75}')

    plt.legend()
    plt.xlabel('The frame index number in the CBS flow')
    plt.ylabel('The latency of an CBS flow via TC7 [us]')
    plt.minorticks_on()
    save_plt_tight(filename)
    plt.cla()
    plt.clf()


results = {}
results_ts = {}
for rate in [0, 100, 300, 500, 700, 900, 950]:
    dirname = f'tc5_{rate:04d}_Mbps'
    results[rate] = DiffSummary(f'results/{dirname}/diff_port0_summary.txt')
    results_ts[rate] = TimestampSummary(f'results/{dirname}/diff_port0.csv')

plot_latency_bar(results, 'results/latency.png')
plot_latency_hist(results_ts, 125, f'results/hist.png')
plot_latency_points(results_ts[500], 125, 'results/each_frame_500.png')
