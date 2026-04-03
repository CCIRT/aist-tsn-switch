# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import unittest
from pyxsdb import PyXsdb
from ats_switch import AtsSwitch, DEFAULT_PRIO

class TestTimestampStatistic(unittest.TestCase):
    xsdb : PyXsdb
    switch : AtsSwitch

    @classmethod
    def setUpClass(cls):
        cls.xsdb = PyXsdb()
        cls.xsdb.connect()
        target = cls.xsdb.select_target()
        cls.switch = AtsSwitch(cls.xsdb, target, 'kc705')

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

    def test_flow_rule(self):
        switch = TestTimestampStatistic.switch

        for tc in range(6):
            with self.assertRaises(ValueError):
                switch.add_flow_rule(0, tc, 1, '192.168.1.10', 1234, '192.168.1.20', 5678)

        with self.assertRaises(ValueError):
            # flow 0 is reserved
            switch.add_flow_rule(0, 6, 0, '192.168.1.10', 1234, '192.168.1.20', 5678)

        with self.assertRaises(ValueError):
            # flow 0 is reserved
            switch.add_flow_rule(0, 6, 16, '192.168.1.10', 1234, '192.168.1.20', 5678)

        switch.add_flow_rule(0, 6, 1, '192.168.1.10', 1234, '192.168.1.20', 5678)
        switch.add_flow_rule(1, 7, 2, None, 1234, '192.168.1.20', 5678)
        switch.add_flow_rule(2, 6, 3, '192.168.1.10', None, '192.168.1.20', 5678)
        switch.add_flow_rule(3, 7, 4, '192.168.1.10', 1234, None, 5678)
        switch.add_flow_rule(0, 6, 5, '192.168.1.10', 1234, '192.168.1.20', None)

        self.assertEqual(switch.get_flow_rule(0, 6, 1), ('192.168.1.10', 1234, '192.168.1.20', 5678))
        self.assertEqual(switch.get_flow_rule(1, 7, 2), (None, 1234, '192.168.1.20', 5678))
        self.assertEqual(switch.get_flow_rule(2, 6, 3), ('192.168.1.10', None, '192.168.1.20', 5678))
        self.assertEqual(switch.get_flow_rule(3, 7, 4), ('192.168.1.10', 1234, None, 5678))
        self.assertEqual(switch.get_flow_rule(0, 6, 5), ('192.168.1.10', 1234, '192.168.1.20', None))

        switch.clear_flow_rule(0, 6, 1)
        switch.clear_flow_rule(1, 7, 2)
        switch.clear_flow_rule(2, 6, 3)
        switch.clear_flow_rule(3, 7, 4)
        switch.clear_flow_rule(0, 6, 5)

        self.assertEqual(switch.get_flow_rule(0, 6, 1), ('255.255.255.255', 65535, '255.255.255.255', 65535))
        self.assertEqual(switch.get_flow_rule(1, 7, 2), ('255.255.255.255', 65535, '255.255.255.255', 65535))
        self.assertEqual(switch.get_flow_rule(2, 6, 3), ('255.255.255.255', 65535, '255.255.255.255', 65535))
        self.assertEqual(switch.get_flow_rule(3, 7, 4), ('255.255.255.255', 65535, '255.255.255.255', 65535))
        self.assertEqual(switch.get_flow_rule(0, 6, 5), ('255.255.255.255', 65535, '255.255.255.255', 65535))

    def test_ats_param(self):
        switch = TestTimestampStatistic.switch

        for tc in range(6):
            with self.assertRaises(ValueError):
                switch.set_ats_param(0, tc, 1, 100, 1542)

        with self.assertRaises(ValueError):
            switch.set_ats_param(0, tc, 16, 100, 1542)

        switch.set_ats_param(0, 6, 0, 100, 1542)
        switch.set_ats_param(1, 7, 2, 200, 154)
        switch.set_ats_param(2, 6, 4, 400, 15)
        switch.set_ats_param(3, 7, 6, 800, 1)

        self.assertEqual(switch.get_ats_param(0, 6, 0), (100, 1542))
        self.assertEqual(switch.get_ats_param(1, 7, 2), (200, 154))
        self.assertEqual(switch.get_ats_param(2, 6, 4), (400, 15))
        self.assertEqual(switch.get_ats_param(3, 7, 6), (800, 1))

    def test_max_residence_time(self):
        switch = TestTimestampStatistic.switch

        for tc in range(6):
            with self.assertRaises(ValueError):
                switch.set_max_residence_time(0, tc, 1_000_000_000)

        switch.set_max_residence_time(0, 6, 0x1234)                    # 16 bit
        switch.set_max_residence_time(1, 7, 0x1234_4567)               # 32 bit
        switch.set_max_residence_time(2, 6, 0x1234_4567_89ab)          # 48 bit
        switch.set_max_residence_time(3, 7, 0x1234_4567_89ab_cdef)     # 64 bit
        switch.set_max_residence_time(0, 7, 0xff_1234_4567_89ab_cdef)  # 72 bit

        self.assertEqual(switch.get_max_residence_time(0, 6), 0x1234)
        self.assertEqual(switch.get_max_residence_time(1, 7), 0x1234_4567)
        self.assertEqual(switch.get_max_residence_time(2, 6), 0x1234_4567_89ab)
        self.assertEqual(switch.get_max_residence_time(3, 7), 0x1234_4567_89ab_cdef)
        self.assertEqual(switch.get_max_residence_time(0, 7), 0xff_1234_4567_89ab_cdef)

    def test_processing_delay_max(self):
        switch = TestTimestampStatistic.switch
        switch.set_processing_delay_max(0xff_1234_4567_89ab_cdef)  # 72 bit

        self.assertEqual(switch.get_processing_delay_max(), 0xff_1234_4567_89ab_cdef)


if __name__ == '__main__':
    unittest.main()
