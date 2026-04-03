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
from plot_util import DiffSummary, TimestampSummary, save_plt_tight

dir_and_labels = [('tc7_only', '(A) TC7'),
                  ('tc7_tc6_1000', '(B) TC7 + TC6'),
                  ]
for rate in [100, 200, 300, 400, 500, 600, 700, 800, 900]:
    dir_and_labels.append((f'tc7_tc5_{rate}', f'(C) TC7 + TC5({rate}M)'))

for rate in [100, 200, 300, 400, 500, 600, 700, 800, 900]:
    dir_and_labels.append((f'tc7_tc6_100_tc5_{rate}', f'(D) TC7 + TC6 + TC5({rate}M)'))

label_and_results = []
for dirname, label in dir_and_labels:
    summary = DiffSummary(f'results/{dirname}/diff_port2_summary.txt')
    label_and_results.append((label, summary))


def plot(label_and_results, label_filter, filename, filename2):
    x = []
    y_min = []
    y_max = []

    for label, result in label_and_results:
        if label_filter(label):
            x.append(label)
            y_min.append(result.min_ts)
            y_max.append(result.max_ts)


    # add newline for odd value
    x2 = x
    x = []
    for i, s in enumerate(x2):
        mod = i % 2
        x.append('\n' * mod + s)

    xval = np.arange(len(x))
    plt.bar(xval, y_min, label='min', width=0.3)
    plt.bar(xval + 0.4, y_max, label='max', width=0.3)
    plt.legend()
    plt.title('Latency of TC7: min, max')
    plt.ylabel('Latency [ns]')
    plt.xticks(xval + 0.20, x)
    save_plt_tight(filename)
    # plt.show()
    plt.cla()
    plt.clf()

    diff0 = np.asarray(y_max) - np.asarray(y_min)
    diff1 = np.asarray(y_max) - y_max[0]

    plt.bar(xval, diff0, label='max-min', width=0.3)
    plt.bar(xval + 0.4, diff1, label='diff from (A)', width=0.3)
    plt.legend()
    plt.title('Latency of TC7: max - min')
    plt.ylabel('Latency [ns]')
    plt.xticks(xval + 0.20, x)
    save_plt_tight(filename2)
    # plt.show()
    plt.cla()
    plt.clf()



targets1 = ['(A) TC7', '(B) TC7 + TC6', '(C) TC7 + TC5(900M)', '(D) TC7 + TC6 + TC5(900M)']
targets2 = ['(A) TC7', '(B) TC7 + TC6', '(C) TC7 + TC5(900M)', '(D) TC7 + TC6 + TC5(900M)']
for rate in [800, 700, 600, 500, 400, 300, 200, 100]:
    targets2.append(f'(D) TC7 + TC6 + TC5({rate}M)')

plot(label_and_results, lambda label: label in targets1, 'results/latency.png', 'results/diff.png')
plot(label_and_results, lambda label: label in targets2, 'results/latency2.png', 'results/diff2.png')
