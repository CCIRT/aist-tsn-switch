# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import unittest
from pyxsdb import PyXsdb
from cbs_switch import CbsSwitch, DEFAULT_PRIO

class TestTimestampStatistic(unittest.TestCase):
    xsdb : PyXsdb
    switch : CbsSwitch

    @classmethod
    def setUpClass(cls):
        cls.xsdb = PyXsdb()
        cls.xsdb.connect()
        target = cls.xsdb.select_target()
        cls.switch = CbsSwitch(cls.xsdb, target, 'zedboard_with_probes')

        hash = cls.switch._addrtab.commit_hash
        if hash is not None:
            # show commit hash
            print('The current bitstream was implemented using the commit hash ' + cls.switch.get_commit_hash() + '.')

    def test_traffic_class(self):
        switch = TestTimestampStatistic.switch
        switch.set_traffic_class(DEFAULT_PRIO, 5)
        switch.set_traffic_class(2, 6)
        switch.set_traffic_class(3, 7)

        self.assertEqual(switch.get_traffic_class(DEFAULT_PRIO), 5)
        self.assertEqual(switch.get_traffic_class(2), 6)
        self.assertEqual(switch.get_traffic_class(3), 7)

    def test_slope(self):
        switch = TestTimestampStatistic.switch

        for tc in range(6):
            with self.assertRaises(ValueError):
                switch.set_slope(tc, 100000, -900000, 1000000, -9000000)

        switch.set_slope(6, 100_000, -900_000, 1_000_000, -9_000_000)
        switch.set_slope(7, 300_000, -700_000, 3_000_000, -7_000_000)
        self.assertEqual(switch.get_slope(6), (100_000, -900_000, 1_000_000, -9_000_000))
        self.assertEqual(switch.get_slope(7), (300_000, -700_000, 3_000_000, -7_000_000))

    def test_flow_control(self):
        switch = TestTimestampStatistic.switch
        switch.set_flow_control(True)
        self.assertEqual(switch.get_flow_control(), True)
        switch.set_flow_control(False)
        self.assertEqual(switch.get_flow_control(), False)

    def test_pulse_generator(self):
        switch = TestTimestampStatistic.switch
        pulse = switch._addrtab.pulse_generator
        if pulse is not None:
            switch.set_pulse_probes(0, 0xff_ffffffff)
            switch.set_pulse_probes(1, 0xaa_aaaaaaaa)
            switch.set_pulse_probes(2, 0x55_55555555)
            switch.set_pulse_probes(3, 0x12_3456789a)
            self.assertEqual(switch.get_pulse_probes(0), 0xff_ffffffff)
            self.assertEqual(switch.get_pulse_probes(1), 0xaa_aaaaaaaa)
            self.assertEqual(switch.get_pulse_probes(2), 0x55_55555555)
            self.assertEqual(switch.get_pulse_probes(3), 0x12_3456789a)

            switch.set_pulse_width(1024)
            self.assertEqual(switch.get_pulse_width(), 1024)

            switch.set_pulse_width(1023)
            self.assertEqual(switch.get_pulse_width(), 1023)

if __name__ == '__main__':
    unittest.main()
