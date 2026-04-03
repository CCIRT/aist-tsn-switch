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
from plot_util import TimestampSummary, save_plt_tight

ts_send = TimestampSummary()
ts_send.read_file('results/rate250_stddev1000/send2.csv')

ts_recv = TimestampSummary()
ts_recv.read_file('results/rate250_stddev1000/recv.csv')


def plot_interval(ts_send, ts_recv, points, filename):
    start_timestamp = ts_send.timestamp_val[0]

    SEND_OFS = 1.0
    RECV_OFS = 0.0

    x0 = np.asarray(ts_send.timestamp_val) - start_timestamp
    y0 = np.zeros(x0.shape) + SEND_OFS

    x1 = np.asarray(ts_recv.timestamp_val) - start_timestamp
    y1 = np.zeros(x1.shape) + RECV_OFS

    plt.plot(x0[:points], y0[:points], 'x-', label=f'send')
    plt.plot(x1[:points], y1[:points], 'x-', label=f'recv')

    for i, val in enumerate(x0[1:points]):
        plt.text(val, SEND_OFS + 0.25 + (i % 2) * 0.25, val - x0[i], fontsize=10)

    for i, val in enumerate(x1[1:points]):
        plt.text(val, RECV_OFS + 0.25 + (i % 2) * 0.25, val - x1[i], fontsize=10)

    plt.legend()
    plt.xlabel('frame timestamp [Cycles]')
    plt.yticks([])
    plt.ylim([-0.5, 2])
    plt.minorticks_on()
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


def plot_hist(ts, label, filename, hist_range):
    x = np.asarray(ts.timestamp_diff[1:])
    plt.hist(x, rwidth=0.8, bins=20, range=hist_range)
    plt.title(f'frame interval histogram ({label})')
    plt.xlabel('frame interval [Cycles]')
    plt.ylabel('the number of frames')
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


plot_interval(ts_send, ts_recv, 10, 'results/interval.png')

hist_range_min = min(ts_send.timestamp_diff[1:])
hist_range_max = max(ts_send.timestamp_diff[1:])
hist_range = (hist_range_min, hist_range_max)

plot_hist(ts_send, 'send', 'results/hist_send.png', hist_range)
plot_hist(ts_recv, 'recv', 'results/hist_recv.png', hist_range)
