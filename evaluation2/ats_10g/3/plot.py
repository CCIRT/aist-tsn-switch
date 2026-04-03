# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import matplotlib.pyplot as plt
import numpy as np
import sys
import math

sys.path.append('../../cbs_10g/common_script')
from plot_util import TimestampSummary, BandwidthSummary, save_plt_tight

frame_size = 1500
# frame_size = 64

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
    # eth(14) + vlan(4) + fcs(4) + ifg(12) + preamble(8) = 42
    bits_per_frame_cir = (frame_size + 42) * 8
    interval_cir = bits_per_frame_cir * 1000 / theoretical_x
    bits_per_frame_max = math.ceil((frame_size + 42) / 8) * 8 * 8 # roundup
    interval_max = bits_per_frame_max * 1000 / theoretical_x
    theoretical_y = interval_cir
    theoretical_y2 = interval_max


    plt.plot(x, y_min, 's', label='min interval [ns]')
    plt.plot(x, y_max, '^', label='max interval [ns]')
    plt.plot(x, y_ave, 'o', label='ave interval [ns]')
    plt.plot(theoretical_x, theoretical_y, label='theoretical value')
    # plt.plot(theoretical_x, theoretical_y2, '--', label='theoretical value (roudup)')

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
    bits_per_frame_cir = (frame_size + 42) * 8
    interval_cir = bits_per_frame_cir * 1000 / theoretical_x
    bits_per_frame_max = math.ceil((frame_size + 42) / 8) * 8 * 8
    interval_max = bits_per_frame_max * 1000 / theoretical_x

    tx_interval = bits_per_frame_max * 1000 / 10000
    tx_frames = 1 / tx_interval

    cir_rate = 1000 / interval_cir * (frame_size - 28) * 8
    cir_rate2 = cir_rate / interval_cir * interval_max
    rx_interval = 1000 / cir_rate2 * (frame_size - 28) * 8
    rx_frames = 1 / rx_interval

    theoretical_y = (1 - rx_frames / tx_frames) * 100
    theoretical_y2 = (10000 - theoretical_x) / 100

    plt.plot(x, y, 'o', label='TC7')
    plt.plot(theoretical_x, theoretical_y, label='theoretical value')
    # plt.plot(theoretical_x, theoretical_y2, '--', label='theoretical value (roudup)')

    plt.legend()
    plt.ylabel('Frame loss [%]')
    plt.xlabel('CommittedInformationRate of TC7 [Mbps]')
    plt.xlim([0, max(x)])
    plt.ylim([0, 100])
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
    # ip(20) + udp(8) = 28
    # eth(14) + vlan(4) + fcs(4) + ifg(12) + preamble(8) = 42
    bits_per_frame_cir = (frame_size + 42) * 8
    interval_cir = bits_per_frame_cir * 1000 / theoretical_x
    bits_per_frame_max = math.ceil((frame_size + 42) / 8) * 8 * 8
    interval_max = bits_per_frame_max * 1000 / theoretical_x

    max_rate = 1000 / interval_max * (frame_size - 28) * 8
    theoretical_y2 = max_rate

    cir_rate = 1000 / interval_cir * (frame_size - 28) * 8
    theoretical_y = cir_rate / interval_cir * interval_max


    plt.plot(x, y, 'o', label='TC7')
    plt.plot(theoretical_x, theoretical_y, label='theoretical value')
    # plt.plot(theoretical_x, theoretical_y2, '--', label='theoretical value (roudup)')

    plt.legend()
    plt.ylabel('Arrival rate [Mbps]')
    plt.xlabel('CommittedInformationRate of TC7 [Mbps]')
    plt.xlim([0, max(x)])
    plt.ylim([0, 10000])
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


cirs = [1000, 2000, 4000, 6000, 8000, 10000]

timestamps = {}
bandwidths = {}

for cir in cirs:
    dirname = f'results/cir_{cir}'
    timestamps[cir] = TimestampSummary(f'{dirname}/recv.csv')
    bandwidths[cir] = BandwidthSummary(f'{dirname}/port2_summary_bandwidth.txt')


plot_interval(timestamps, 156.25, 'results/recv_interval.png')
plot_loss(bandwidths, 'results/frame_loss.png')
plot_arrival_rate(bandwidths, 'results/arrival_rate.png')
