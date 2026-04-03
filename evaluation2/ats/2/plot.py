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
from plot_util import TimestampSummary, save_plt_tight

FREQ_MHZ = 125


def plot_interval(ts, burst, freq_mhz, filename):
    # Since the upper 3-bit of timestamp is reserved, get lower 29 bits.
    TIMESTAMP_MASK = 0x1fff_ffff

    cycle_time_ns = 1000 / freq_mhz

    y_array = [tdiff * cycle_time_ns for tdiff in ts.timestamp_diff[1:]]

    x = np.arange(len(y_array))
    y = np.asarray(y_array)

    plt.figure(figsize=(12.9, 4.8))
    plt.plot(x, y, 'o', markersize=2)

    plt.title(f'Burst length: {burst} frames')
    plt.xlabel('frame number')
    plt.ylabel('frame interval [ns]')
    plt.yticks([0, 50000, 100000, 150000])
    plt.ylim([0, 150000])
    plt.minorticks_on()
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


def plot_burst_length(bursts, timestamps, filename):
    def get_burst_length(ts):
        start_tid = ts.timestamp_id[0]
        burst_len = 0
        for i, tid in enumerate(ts.timestamp_id):
            if tid == start_tid + i:
                burst_len = i
            else:
                break

        return burst_len

    plt.figure(figsize=(6, 4))

    x = np.asarray(bursts)
    y = np.asarray([get_burst_length(ts) for ts in timestamps])

    y_ofs = 1.0
    for xi, yi in zip(x, y):
        plt.text(xi, yi + y_ofs, yi, fontsize=10)

    plt.plot(x, y, 's', markersize=2)
    plt.grid()
    plt.xlabel('N (CommittedBurstSize = 1522 Byte * N)')
    plt.ylabel('Number of observed burst frames')
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


max_residence_times = [50000000, 4294967295]
bursts = [1, 2, 4, 8, 16, 32, 48, 64]

results = {}
for max_residence_time in max_residence_times:
    for burst in bursts:
        ts = TimestampSummary()
        ts.read_file(f'results/burst_{burst}_max_residence_time_{max_residence_time}/recv.csv')

        results[(burst, max_residence_time)] = ts

for burst in bursts:
    plot_interval(results[(burst, max_residence_times[0])], burst, FREQ_MHZ, f'results/interval_burst{burst}.png')

plot_burst_length(bursts, [results[(burst, max_residence_times[0])] for burst in bursts], 'results/burst_length.png')
