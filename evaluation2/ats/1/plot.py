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
from plot_util import DiffSummary, save_plt_tight


def plot(results, markers, label_func, target_func, ylabel, filename):
    for k in results.keys():
        x = np.asarray([k for k in results[k].keys()])
        y = np.asarray([target_func(v) for v in results[k].values()])

        plt.plot(x, y, markers[k], label=label_func(k))

    plt.legend()
    plt.xlabel('frame size [Byte]')
    plt.ylabel(ylabel)
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()


def plot_eval1():
    tcs = [5, 7]
    lengths = [64, 100, 300, 500, 700, 900, 1100, 1300, 1500]
    cirs = [10, 100]

    results = defaultdict(lambda: {})
    for tc in tcs:
        if tc == 5:
            for length in lengths:
                dirname = f'tc{tc}_sz{length:04d}'
                summary = DiffSummary()
                summary.read_file(f'results/{dirname}/diff_port2_summary.txt')
                results[(tc, None)][length] = summary
            continue

        for cir in cirs:
            for length in lengths:
                dirname = f'tc{tc}_cir{cir}_sz{length:04d}'
                summary = DiffSummary()
                summary.read_file(f'results/{dirname}/diff_port2_summary.txt')
                results[(tc, cir)][length] = summary

    markers = {(5, None): 'x-', (7, 10): '_-', (7, 100): '|-'}
    def label_func(key):
        label = f'tc{key[0]}'
        if key[1] is not None:
            label += f' {key[1]}Mbps'
        return label

    plot(results, markers, label_func, lambda x: x.min_ts, 'Latency (min) [ns]', 'results/min_lat.png')
    plot(results, markers, label_func, lambda x: x.max_ts, 'Latency (max) [ns]', 'results/max_lat.png')
    plot(results, markers, label_func, lambda x: x.avg_ts, 'Latency (avg) [ns]', 'results/avg_lat.png')
    plot(results, markers, label_func, lambda x: x.std_ts, 'Latency (std) [ns]', 'results/std_lat.png')

def plot_eval1F():
    tc = 7
    cir = 100
    lengths = [64, 100, 300, 500, 700, 900, 1100, 1300, 1500]
    pdms = [0, 10, 13, 20]

    results = defaultdict(lambda: {})
    for pdm in pdms:
        for length in lengths:
            dirname = f'tc{tc}_cir{cir}_sz{length:04d}_pdm{pdm}us'
            summary = DiffSummary()
            summary.read_file(f'results/{dirname}/diff_port2_summary.txt')
            results[pdm][length] = summary
            continue

    markers = {0: 'x-', 10: '_-', 13: '|-', 20: 'v-'}
    def label_func(key):
        return f'PDM {key}us'

    plot(results, markers, label_func, lambda x: x.min_ts, 'Latency (min) [ns]', 'results/min_lat_pdm.png')
    plot(results, markers, label_func, lambda x: x.max_ts, 'Latency (max) [ns]', 'results/max_lat_pdm.png')
    plot(results, markers, label_func, lambda x: x.avg_ts, 'Latency (avg) [ns]', 'results/avg_lat_pdm.png')
    plot(results, markers, label_func, lambda x: x.std_ts, 'Latency (std) [ns]', 'results/std_lat_pdm.png')

plot_eval1()
plot_eval1F()
