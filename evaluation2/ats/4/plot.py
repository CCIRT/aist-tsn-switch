# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import matplotlib.pyplot as plt
import numpy as np
import sys

sys.path.append('../../cbs/common_script')
from plot_util import BandwidthSummary, TimestampSummary, save_plt_tight


def plot_bandwidth(bandwidths, filename):
    width = 0.4
    c_ofs = 0.45

    for i, b in enumerate(bandwidths):
        x = [i * c_ofs]
        y = [b.recv_rate]
        plt.bar(x, y, width=width, label=f'flow{i+1}')

    ETH = 14
    VLAN = 4
    FCS = 4
    PREAMBLE = 8
    IFG = 12

    frame_size = 1500
    l2_frame_len = frame_size + ETH + VLAN + FCS
    l1_frame_len = l2_frame_len + PREAMBLE + IFG
    expected_y1 = 100 * l2_frame_len / l1_frame_len
    expected_y2 = 200 * l2_frame_len / l1_frame_len
    plt.axhline(y=expected_y1, color='tab:blue', linestyle='dashed', label='flow1 CIR')
    plt.axhline(y=expected_y2, color='tab:orange', linestyle='dashed', label='flow2 CIR')

    plt.legend()
    plt.ylabel('Receive rate [Mbps]')
    plt.xticks([])
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()

def plot_interval(summary, freq_mhz, filename):
    # NOTE: This grouping should be run in eval.py.
    # However, since there are no function in current evaluation scheme, we group receive frames here.
    group0_ts = [summary.timestamp_val[i] for i, _ in enumerate(summary.timestamp_val) if summary.timestamp_id[i] % 2 == 0]
    group1_ts = [summary.timestamp_val[i] for i, _ in enumerate(summary.timestamp_val) if summary.timestamp_id[i] % 2 == 1]

    us_per_cycle = 1 / freq_mhz

    # get 200 to 300 frames
    group0_interval = []
    group1_interval = []
    for i in range(200, 300):
        try:
            group0_interval.append((group0_ts[i+1] - group0_ts[i]) * us_per_cycle)
            group1_interval.append((group1_ts[i+1] - group1_ts[i]) * us_per_cycle)
        except:
            break

    print(f'average interval of flow1: {np.average(np.asarray(group0_interval))}')
    print(f'average interval of flow2: {np.average(np.asarray(group1_interval))}')

    # plot recv interval.
    x = np.arange(1, len(group0_interval) + 1)
    plt.figure(figsize=(12.9, 4.8))
    plt.plot(x, group0_interval, 'o-', label='flow1', markersize=3)
    plt.plot(x, group1_interval, 'o-', label='flow2', markersize=3)
    plt.legend()
    plt.ylabel('Arrival frame interval [us]')
    plt.xlabel('Frame index number')
    plt.xlim([0, 101])
    plt.ylim([0, 140])
    plt.grid()
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


bandwidths = []
bandwidths.append(BandwidthSummary('results/cirs_100_200/port0_summary_bandwidth.txt'))
bandwidths.append(BandwidthSummary('results/cirs_100_200/port1_summary_bandwidth.txt'))

plot_bandwidth(bandwidths, 'results/receive_rate.png')
plot_interval(TimestampSummary('results/cirs_100_200/recv.csv'), 125, 'results/interval.png')
