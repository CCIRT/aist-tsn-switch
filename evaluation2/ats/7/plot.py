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
from plot_util import DiffSummary, TimestampSummary, BandwidthSummary, save_plt_tight


def plot_latencies(latencies, filename, key_func=lambda x: True, show_mrt=False):
    # rates
    markers = ['o-', '^--']
    marker_idx = 0
    for mrt, summary in latencies.items():
        if not key_func(mrt):
            continue

        x = summary.keys()
        y_min = [v.min_ts / 1000 for v in summary.values()]
        y_avg = [v.avg_ts / 1000 for v in summary.values()]
        y_max = [v.max_ts / 1000 for v in summary.values()]

        if show_mrt:
            mrt_us = mrt / 1000000
            plt.plot(x, y_min, markers[marker_idx], label=f'min (MRT {mrt_us} us)')
            plt.plot(x, y_avg, markers[marker_idx], label=f'ave (MRT {mrt_us} us)')
            plt.plot(x, y_max, markers[marker_idx], label=f'max (MRT {mrt_us} us)')
        else:
            plt.plot(x, y_min, markers[marker_idx], label=f'min')
            plt.plot(x, y_avg, markers[marker_idx], label=f'ave')
            plt.plot(x, y_max, markers[marker_idx], label=f'max')
        marker_idx += 1

    plt.legend()
    plt.xlabel('The CIR of the competing ATS flow via TC7 [Mbps]')
    plt.ylabel('The latency of an ATS flow via TC7 [us]')
    plt.minorticks_on()
    save_plt_tight(filename)
    plt.cla()
    plt.clf()


def plot_latency_points(timestamp_lats: TimestampSummary, freq_mhz, filename, y_start=0):
    us_per_cycle = 1 / freq_mhz
    y = np.array(timestamp_lats.timestamp_val) * us_per_cycle
    y = y[y_start:]
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


def plot_arrival_rate(records, filename):
    # rates
    markers = ['o-', '^--']
    marker_idx = 0
    for mrt, summary in records.items():
        x = summary.keys()
        y0 = np.array([v[0].recv_rate for v in summary.values()])
        y1 = np.array([v[1].recv_rate for v in summary.values()])
        ys = y0 + y1

        mrt_us = mrt / 1000000
        plt.plot(x, y0, markers[marker_idx], label=f'Port 0')
        # plt.plot(x, y1, markers[marker_idx], label=f'Port 1')
        plt.plot(x, ys, markers[marker_idx], label=f'Port 0 + Port 1')
        marker_idx += 1

    plt.legend()
    plt.xlabel('The CIR of the competing ATS flow via TC7 of TC7 (Port 1) [Mbps]')
    plt.ylabel('Arrival rate [Mbps]')
    plt.minorticks_on()
    save_plt_tight(filename)
    plt.cla()
    plt.clf()


max_residence_times = [134217728]
cirs = [0, 100, 300, 500, 700, 900, 1000]

latencies = defaultdict(lambda: {})
bandwidths = defaultdict(lambda: defaultdict(lambda: [None, None]))
for mrt in max_residence_times:
    for cir in cirs:
        dirname = f'mrt_{mrt}_tc7_CIR{cir}'
        latencies[mrt][cir] = DiffSummary(f'results/{dirname}/diff_port0_summary.txt')
        bandwidths[mrt][cir][0] = BandwidthSummary(f'results/{dirname}/port0_summary_bandwidth.txt')
        if cir != 0:
            bandwidths[mrt][cir][1] = BandwidthSummary(f'results/{dirname}/port1_summary_bandwidth.txt')
        else:
            bandwidths[mrt][cir][1] = BandwidthSummary()

plot_latencies(latencies, f'results/latency_summary.png')
plot_arrival_rate(bandwidths, f'results/arrival_rate.png')

mrt = 134217728
for cir in cirs:
    print('------------------------------')
    print(f'cir = {cir}, port0 (TC7)')
    dirname = f'mrt_{mrt}_tc7_CIR{cir}'
    timestamp_lats = TimestampSummary(f'results/{dirname}/diff_port0.csv')
    plot_latency_points(timestamp_lats, 125, f'results/each_frame_{cir}.png')

    if cir >= 900:
        print(f'cir = {cir}, port0 (TC7), skip first 100 frames')
        plot_latency_points(timestamp_lats, 125, f'results/each_frame_{cir}_skip100.png', y_start=100)

    if cir != 0:
        print(f'cir = {cir}, port1 (TC5)')
        dirname = f'mrt_{mrt}_tc7_CIR{cir}'
        timestamp_lats = TimestampSummary(f'results/{dirname}/diff_port1.csv')
        plot_latency_points(timestamp_lats, 125, f'results/each_frame_{cir}_mrt{mrt}_port1.png')
