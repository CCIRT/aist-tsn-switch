# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import unittest
import csv
from tsn_efcc import TimestampStatistic

class TestTimestampStatistic(unittest.TestCase):
    def test_empty(self):
        stat = TimestampStatistic()
        self.assertEqual(stat.get_timestamp_ids().shape[0], 0)
        self.assertEqual(stat.get_timestamps().shape[0], 0)
        self.assertEqual(stat.get_stats(), {})

    def test_push(self):
        stat = TimestampStatistic()
        ids = [1, 2, 3]
        vals = [10, 20, 30]
        stats = {}

        for id_, val in zip(ids, vals):
            stat.push(id_, val)
            stats[id_] = val

        self.assertEqual(list(stat.get_timestamp_ids()), ids)
        self.assertEqual(list(stat.get_timestamps()), vals)
        self.assertEqual(stat.get_stats(), stats)

    def test_push_list(self):
        stat = TimestampStatistic()
        ids = [1, 2, 3]
        vals = [10, 20, 30]

        stat.push_list(ids, vals)
        stats = {k: v for k, v in zip(ids, vals)}

        self.assertEqual(list(stat.get_timestamp_ids()), ids)
        self.assertEqual(list(stat.get_timestamps()), vals)
        self.assertEqual(stat.get_stats(), stats)

    def test_push_dup(self):
        stat = TimestampStatistic()
        ids = [1, 2, 3]
        vals = [10, 20, 30]

        stat.push_list(ids, vals)
        stats = {k: v for k, v in zip(ids, vals)}

        ids = [2, 4, 6]
        vals = [40, 50, 60]

        stat.push_list(ids, vals)
        for id_, val in zip(ids, vals):
            if id_ not in stats:
                stats[id_] = val

        self.assertEqual(list(stat.get_timestamp_ids()), list(stats.keys()))
        self.assertEqual(list(stat.get_timestamps()), list(stats.values()))
        self.assertEqual(stat.get_stats(), stats)

    def test_subtract(self):
        ids0 = [1, 2, 3]
        vals0 = [10, 20, 30]
        ids1 = [1, 3, 5]
        vals1 = [30, 40, 50]

        stat0 = TimestampStatistic(ids0, vals0)
        stat1 = TimestampStatistic(ids1, vals1)
        diff = stat1.subtract(stat0)

        self.assertEqual(list(diff.get_timestamp_ids()), [1, 3])
        self.assertEqual(list(diff.get_timestamps()), [20, 10])

    def test_add_constant(self):
        ids = [1, 2, 3]
        vals = [10, 20, 30]

        stat0 = TimestampStatistic(ids, vals)
        stat1 = stat0.add_constant(100)

        self.assertEqual(list(stat0.get_timestamp_ids()), list(stat1.get_timestamp_ids()))
        self.assertEqual(list(stat0.get_timestamps()), vals)
        self.assertEqual(list(stat1.get_timestamps()), [110, 120, 130])

    def test_filter(self):
        ids = [1, 2, 3]
        vals = [10, 20, 30]

        def filter_func(id_):
            return id_ % 2 == 0

        stat0 = TimestampStatistic(ids, vals)
        stat1 = stat0.filter(filter_func)

        self.assertEqual(list(stat1.get_timestamp_ids()), [2])
        self.assertEqual(list(stat1.get_timestamps()), [20])

    def test_filter_by_timestamp(self):
        ids = [1, 2, 3]
        vals = [10, 20, 30]

        def filter_func(val):
            return val >= 20

        stat0 = TimestampStatistic(ids, vals)
        stat1 = stat0.filter_by_timestamp(filter_func)

        self.assertEqual(list(stat1.get_timestamp_ids()), [2, 3])
        self.assertEqual(list(stat1.get_timestamps()), [20, 30])

    def test_get_intersection(self):
        ids0 = [1, 2, 3]
        vals0 = [10, 20, 30]
        ids1 = [1, 3, 5]
        vals1 = [100, 200, 300]

        stat0 = TimestampStatistic(ids0, vals0)
        stat1 = TimestampStatistic(ids1, vals1)

        intersect0 = stat0.get_intersection(stat1)
        intersect1 = stat1.get_intersection(stat0)

        self.assertEqual(list(intersect0.get_timestamp_ids()), [1, 3])
        self.assertEqual(list(intersect0.get_timestamps()), [10, 30])
        self.assertEqual(list(intersect1.get_timestamp_ids()), [1, 3])
        self.assertEqual(list(intersect1.get_timestamps()), [100, 200])

    def test_subgroup_by_timestamp(self):
        ids0 = [1, 2, 3, 4]
        vals0 = [10, 20, 30, 40]

        stat0 = TimestampStatistic(ids0, vals0)
        substat0 = stat0.subgroup_by_timestamp(20, 31)

        self.assertEqual(list(substat0.get_timestamp_ids()), [2, 3])
        self.assertEqual(list(substat0.get_timestamps()), [20, 30])

    def test_calc_bandwidth(self):
        ids0 = [1, 2, 3, 4, 5]
        vals0 = [10, 20, 30, 40, 50]

        def func_id_to_size(id_):
            if id_ % 2 == 0:
                return 100
            return 0

        duration_sec = 10

        stat0 = TimestampStatistic(ids0, vals0)
        bw0 = stat0.calc_bandwidth(func_id_to_size, duration_sec)

        # Expected value: (number of even funcs) * 100 / duration_sec = 20
        self.assertAlmostEqual(bw0, 20)

    def test_summary_bandwidth(self):
        # Note: this test does not test values. Run only display result
        ids0 = [1, 2, 3, 4, 5]
        vals0 = [10, 20, 30, 40, 50]
        # id 2 is dropped
        ids1 = [1, 3, 4, 5]
        vals1 = [15, 35, 45, 55]

        stat0 = TimestampStatistic(ids0, vals0)
        stat1 = TimestampStatistic(ids1, vals1)

        def func_id_to_size(id_):
            return 1

        TimestampStatistic.summary_bandwidth(stat0, stat1, freq_mhz=1000, func_id_to_size=func_id_to_size, name='test_summary_bandwidth')

    def test_summary(self):
        # Note: this test does not test values. Run only display result
        ids0 = [1, 2, 3, 4, 5]
        vals0 = [10, 20, 30, 40, 50]
        stat0 = TimestampStatistic(ids0, vals0)

        stat0.summary(freq_mhz=1000, name='test_summary')

    def test_save_load_file(self):
        ids0 = [1, 2, 3, 4, 5]
        vals0 = [10, 20, 30, 40, 50]

        # save
        stat0 = TimestampStatistic(ids0, vals0)
        stat0.save_to_binary('test.bin')

        # load
        stat1 = TimestampStatistic()
        stat1.read_binary_file('test.bin')
        self.assertEqual(list(stat1.get_timestamp_ids()), ids0)
        self.assertEqual(list(stat1.get_timestamps()), vals0)

        # save (csv)
        stat1.save_to_csv('test.csv')
        with open('test.csv', 'r') as f:
            reader = csv.DictReader(f)
            for i, row in enumerate(reader):
                self.assertEqual(int(row['timestamp_id'], base=0), ids0[i])
                self.assertEqual(int(row['timestamp_val'], base=0), vals0[i])
                if i > 0:
                    self.assertEqual(int(row['timestamp_diff'], base=0), vals0[i] - vals0[i - 1])


if __name__ == '__main__':
    unittest.main()
