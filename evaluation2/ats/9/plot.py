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
    marker = 'o-'

    x = latencies.keys()
    y_min = [v.min_ts / 1000 for v in latencies.values()]
    y_avg = [v.avg_ts / 1000 for v in latencies.values()]
    y_max = [v.max_ts / 1000 for v in latencies.values()]
    y_std = [v.std_ts / 1000 for v in latencies.values()]

    plt.plot(x, y_min, marker, label=f'min')
    plt.plot(x, y_avg, marker, label=f'ave')
    plt.plot(x, y_max, marker, label=f'max')

    plt.legend()
    plt.xlabel('The transmit rate of the competing best effort flow via TC5 [Mbps]')
    plt.ylabel('The latency of an ATS flow via TC7 [us]')
    plt.title('Latency of an ATS flow via TC7 competing an ATS flow via TC6 and a best-effort flow via TC5')
    plt.minorticks_on()
    save_plt_tight(filename)
    plt.cla()
    plt.clf()

def plot_latencies2(latencies, filename):
    # rates
    marker = 'o-'

    x = ['A', 'B', 'C', 'D']

    y_min = []
    y_avg = []
    y_max = []
    for key in x:
        target = latencies[key]
        if key == 'D':
            target = target[700]

        y_min.append(target.min_ts / 1000)
        y_avg.append(target.avg_ts / 1000)
        y_max.append(target.max_ts / 1000)

    plt.plot(x, y_min, marker, label=f'min')
    plt.plot(x, y_avg, marker, label=f'ave')
    plt.plot(x, y_max, marker, label=f'max')

    plt.legend()
    plt.xlabel('Configurations. (A): TC7, (B): TC7 + TC6, (C): TC7 + TC5 (900 Mbps), (D): TC7 + TC6 + TC5 (900 Mbps)')
    plt.ylabel('The latency of an ATS flow via TC7 [us]')
    plt.minorticks_on()
    save_plt_tight(filename)
    plt.cla()
    plt.clf()


def plot_latency_points(timestamp_lats: TimestampSummary, freq_mhz, filename):
    us_per_cycle = 1 / freq_mhz
    y = np.array(timestamp_lats.timestamp_val) * us_per_cycle
    y = y[20:]
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

    print(f'min: {minval}, max: {maxval}, max - min: {maxval - minval}, avg: {avgval}, 25%: {p25}, 50%: {p50}, 75%: {p75}')

    plt.legend()
    plt.xlabel('The frame index number in the ATS flow')
    plt.ylabel('The latency of an ATS flow via TC7 [us]')
    plt.minorticks_on()
    save_plt_tight(filename)
    plt.cla()
    plt.clf()


latencies = {}

# (A)
dirname = 'tc7_only'
latencies['A'] = DiffSummary(f'results/{dirname}/diff_port0_summary.txt')

# (B)
dirname = 'tc7_tc6'
latencies['B'] = DiffSummary(f'results/{dirname}/diff_port0_summary.txt')

# (C)
dirname = 'tc7_tc5_900'
latencies['C'] = DiffSummary(f'results/{dirname}/diff_port0_summary.txt')

# (D)
latencies['D'] = {}
for rate in [100, 300, 500, 700, 900]:
    dirname = f'tc7_tc6_tc5_{rate}'
    latencies['D'][rate] = DiffSummary(f'results/{dirname}/diff_port0_summary.txt')


plot_latencies(latencies['D'], f'results/latency_tc7_tc6_tc5.png')
plot_latencies2(latencies, f'results/latency_all.png')

# (D)
for rate in [100, 300, 500, 700, 900]:
    dirname = f'tc7_tc6_tc5_{rate}'
    ts = TimestampSummary(f'results/{dirname}/diff_port0.csv')
    plot_latency_points(ts, 125, f'results/lat_points_tc7_tc6_tc5_{rate}.png')
