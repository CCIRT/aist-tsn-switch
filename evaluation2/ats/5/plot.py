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
from plot_util import BandwidthSummary, save_plt_tight

def plot_frame_loss(records, title, filename):
    # rates
    x = records.keys()

    y_port0 = [x[0].drop_rate for x in records.values()]
    y_port1 = [x[1].drop_rate for x in records.values()]

    plt.plot(x, y_port0, 'o', label='Port 0')
    plt.plot(x, y_port1, 'o', label='Port 1')

    plt.legend()
    plt.title(title)
    plt.xlabel('Transmit rate of TC7 (Port 0) [Mbps]')
    plt.ylabel('Frame Loss [%]')
    plt.ylim([0, 100])
    plt.minorticks_on()
    save_plt_tight(filename)
    plt.cla()
    plt.clf()


def plot_arrival_rate(records, title, filename):
    # rates
    x = records.keys()

    y_port0 = [x[0].recv_rate for x in records.values()]
    y_port1 = [x[1].recv_rate for x in records.values()]
    y_sum = [x[0].recv_rate + x[1].recv_rate for x in records.values()]

    plt.plot(x, y_port0, 'o', label='Port 0')
    plt.plot(x, y_port1, 'o', label='Port 1')
    plt.plot(x, y_sum, 'D', label='Port 0 + Port 1')

    plt.legend()
    plt.title(title)
    plt.xlabel('Transmit rate of TC7 (Port 0) [Mbps]')
    plt.ylabel('Arrival rate [Mbps]')
    plt.minorticks_on()
    save_plt_tight(filename)
    plt.cla()
    plt.clf()



rates0 = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000]
rate1 = 1000

tc0 = 7
tc1 = 5
records = defaultdict(lambda: [BandwidthSummary(), BandwidthSummary()])
for rate0 in rates0:
    dirname = f'tc{tc0}_{rate0}_tc{tc1}_{rate1}'
    if rate0 != 0:
       records[rate0][0].read_file(f'results/{dirname}/port0_summary_bandwidth.txt')
    records[rate0][1].read_file(f'results/{dirname}/port1_summary_bandwidth.txt')

plot_frame_loss(records, f'Frame Loss (Port 0: TC{tc0}, Port 1: TC{tc1})', f'results/frame_loss_tc{tc0}_tc{tc1}.png')
plot_arrival_rate(records, f'Arrival Rate (Port 0: TC{tc0}, Port 1: TC{tc1})', f'results/arrival_rate_tc{tc0}_tc{tc1}.png')
