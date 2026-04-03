# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import csv
import matplotlib.pyplot as plt


class DiffSummary():
    """Parser class of *_summary.txt
    """
    def __init__(self, filename=None):
        self.min_ts = 0
        self.max_ts = 0
        self.avg_ts = 0
        self.std_ts = 0

        if filename is not None:
            self.read_file(filename)

    def read_file(self, filename):
        with open(filename, 'r') as f:
            for line in f.readlines():
                if 'Timestamp:' in line:
                    val = float(line.split(' ')[2])

                    if 'Minimum' in line:
                        self.min_ts = val
                    elif 'Maximum' in line:
                        self.max_ts = val
                    elif 'Average' in line:
                        self.avg_ts = val
                    elif 'Stddev' in line:
                        self.std_ts = val
                    else:
                        raise ValueError(f'unexpected input line: {line}')


class TimestampSummary():
    """Parser class of *.csv
    """
    def __init__(self, filename=None):
        self.timestamp_id = []
        self.timestamp_val = []
        self.timestamp_diff = []

        if filename is not None:
            self.read_file(filename)

    def read_file(self, filename):
        with open(filename, 'r') as f:
            reader = csv.DictReader(f)

            for row in reader:
                self.timestamp_id.append(int(row['timestamp_id'], 0))
                self.timestamp_val.append(int(row['timestamp_val']))
                self.timestamp_diff.append(int(row['timestamp_diff']))


class BandwidthSummary():
    """Parser class of *_summary_bandwidth.txt
    """
    def __init__(self, filename=None):
        self.sent_frames = 0
        self.send_rate = 0
        self.recvd_frames = 0
        self.recv_rate = 0
        self.dropped_frames = 0
        self.drop_rate = 0

        if filename is not None:
            self.read_file(filename)

    def read_file(self, filename):
        with open(filename, 'r') as f:
            lines = f.readlines()

            self.sent_frames = int(lines[2].split(' ')[-1])
            self.send_rate = float(lines[3].split(' ')[-2])
            self.recvd_frames = int(lines[4].split(' ')[-1])
            self.recv_rate = float(lines[5].split(' ')[-2])
            self.dropped_frames = int(lines[6].split(' ')[-1])
            self.drop_rate = float(lines[7].split(' ')[-2])


def save_plt_tight(filename):
    plt.savefig(filename, bbox_inches='tight', pad_inches=0.1)
