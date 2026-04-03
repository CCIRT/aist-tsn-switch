# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import matplotlib.pyplot as plt
import numpy as np
import sys

sys.path.append('../../cbs/common_script')
from plot_util import TimestampSummary, BandwidthSummary, save_plt_tight


def plot_interval(recv_timestamps, freq_mhz, filename):
    x = []
    y_min = []
    y_max = []
    y_ave = []

    for k, v in recv_timestamps.items():
        x.append(k)

        # intervals [ns]
        intervals = np.array(v.timestamp_diff[1:]) * 1000 / freq_mhz
        y_min.append(np.min(intervals))
        y_max.append(np.max(intervals))
        y_ave.append(np.average(intervals))

    theoretical_x = np.arange(min(x), max(x) + 1, 1)
    theoretical_y = 1542 * 8 * 1000 / theoretical_x

    plt.plot(x, y_min, 's', label='min interval [ns]')
    plt.plot(x, y_max, '^', label='max interval [ns]')
    plt.plot(x, y_ave, 'o', label='ave interval [ns]')
    plt.plot(theoretical_x, theoretical_y, label='theoretical value')

    plt.legend()
    plt.ylabel('Receive frame interval [ns]')
    plt.xlabel('CommittedInformationRate [Mbps]')
    plt.xlim([0, x[-1]])
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


def plot_loss(_bandwidths, filename):
    x = []
    y = []

    for k, v in _bandwidths.items():
        x.append(k)
        y.append(v.drop_rate)

    theoretical_x = np.arange(min(x), max(x) + 1, 1)
    theoretical_y = (1000 - theoretical_x) / 10

    plt.plot(x, y, 'o', label='TC7')
    plt.plot(theoretical_x, theoretical_y, label='theoretical value')

    plt.legend()
    plt.ylabel('Frame loss [%]')
    plt.xlabel('CommittedInformationRate of TC7 [Mbps]')
    plt.xlim([0, max(x)])
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()

def plot_arrival_rate(_bandwidths, filename):
    x = []
    y = []

    for k, v in _bandwidths.items():
        x.append(k)
        y.append(v.recv_rate)

    theoretical_x = np.arange(min(x), max(x) + 1, 1)
    theoretical_y = theoretical_x * 1472 / 1542

    plt.plot(x, y, 'o', label='TC7')
    plt.plot(theoretical_x, theoretical_y, label='theoretical value')

    plt.legend()
    plt.ylabel('Arrival rate [Mbps]')
    plt.xlabel('CommittedInformationRate of TC7 [Mbps]')
    plt.xlim([0, max(x)])
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


cirs = [100, 200, 400, 600, 800, 1000]

timestamps = {}
bandwidths = {}

for cir in cirs:
    dirname = f'results/cir_{cir}'
    timestamps[cir] = TimestampSummary(f'{dirname}/recv.csv')
    bandwidths[cir] = BandwidthSummary(f'{dirname}/port2_summary_bandwidth.txt')


plot_interval(timestamps, 125, 'results/recv_interval.png')
plot_loss(bandwidths, 'results/frame_loss.png')
plot_arrival_rate(bandwidths, 'results/arrival_rate.png')
