# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import csv
from collections import defaultdict
import matplotlib.pyplot as plt
import numpy as np
import sys

sys.path.append('../../cbs/common_script')
from plot_util import DiffSummary, TimestampSummary, save_plt_tight


def plot_latencies(latencies, filename):
    # rates
    x = latencies.keys()
    y_min = [v.min_ts / 1000 for v in latencies.values()]
    y_avg = [v.avg_ts / 1000 for v in latencies.values()]
    y_max = [v.max_ts / 1000 for v in latencies.values()]

    plt.plot(x, y_min, 'o-', label='min')
    plt.plot(x, y_avg, 'o-', label='avg')
    plt.plot(x, y_max, 'o-', label='max')

    plt.legend()
    plt.xlabel('The transmit rate of the competing best effort flow via TC5 [Mbps]')
    plt.ylabel('The latency of ATS flow via TC7 [us]')
    plt.minorticks_on()
    save_plt_tight(filename)
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
    plt.xlabel('The frame index number in the ATS flow')
    plt.ylabel('The latency of an ATS flow via TC7 [us]')
    plt.minorticks_on()
    save_plt_tight(filename)
    plt.cla()
    plt.clf()


rate0 = 97
rates1 = [0, 100, 300, 500, 700, 900, 1000]

tc0 = 7
tc1 = 5
latencies = {}
for rate1 in rates1:
    dirname = f'tc{tc0}_{rate0}_tc{tc1}_{rate1}'
    latencies[rate1] = DiffSummary(f'results/{dirname}/diff_port0_summary.txt')

plot_latencies(latencies, 'results/latency_summary.png')

rate1 = 500
dirname = f'tc{tc0}_{rate0}_tc{tc1}_{rate1}'
timestamp_lats = TimestampSummary(f'results/{dirname}/diff_port0.csv')
plot_latency_points(timestamp_lats, 125, 'results/each_frame_500.png')
