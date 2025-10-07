# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import cbs_switch
import copy
import os
import sys
import tsn_efcc
import pyxsdb

sys.path.append('../common_script')
import utility
from network_defines import get_default_mac, get_default_ip
import cbs_switch_loader as swloader


class TestModule(utility.TestModuleBase):
    def __init__(self, args):
        super().__init__(args)
        self.cbs = swloader.open_cbs_switch(self.xsdb, self.args.switch_jtag_target, args)
        self.send_port0 = self.args.send_port0
        self.send_port1 = self.args.send_port1
        self.recv_port = self.args.recv_port

        dst_mac, _ = get_default_mac(self.crafter, self.recv_port)
        src_mac0, _ = get_default_mac(self.crafter, self.send_port0)
        src_mac1, _ = get_default_mac(self.crafter, self.send_port1)
        utility.learn_fdb(self.crafter, src_mac0, dst_mac, self.send_port0, self.recv_port)
        utility.learn_fdb(self.crafter, src_mac1, dst_mac, self.send_port1, self.recv_port)

        # TCP -> (vlan_id, pcp) mapping
        self.vlan_pcp = {5: (1, 2),
                         7: (2, 3)}
        for tc in self.vlan_pcp.keys():
            self.cbs.set_traffic_class(self.vlan_pcp[tc][1], tc)

    def test(self, tc5_rate, result_dir):
        # 97 Mbps
        tc7_rate = 97
        idle_slope = int(tc7_rate * 10000)
        send_slope = idle_slope - 1000000
        self.cbs.set_slope(7, idle_slope, send_slope)

        if tc5_rate == 0:
            # As no TC5 frames are sent, only 1000 frames are required for measurement.
            num_frames = 1000

            _, frame_size_tc7 = self._prepare_frames_with_rate(self.send_port0, self.recv_port, 7, tc7_rate)
            _, frame_size = [frame_size_tc7, 0]

            results = self._do_transfer([self.send_port0], [self.send_port0, self.recv_port], num_frames)
            self._report_latency(results, [self.send_port0], self.recv_port, result_dir)
            self._report_bandwidth(results, [self.send_port0], self.recv_port, lambda x: frame_size, result_dir)
        else:
            num_frames = int(1000 * (tc7_rate + tc5_rate) / tc7_rate)

            _, frame_size_tc7 = self._prepare_frames_with_rate(self.send_port0, self.recv_port, 7, tc7_rate)
            _, frame_size_tc5 = self._prepare_frames_with_rate(self.send_port1, self.recv_port, 5, tc5_rate)

            def size_func(tid):
                # The most significant 3 bits are reserved for port id.
                port = tid >> 29

                if port == self.send_port0:
                    return frame_size_tc7
                elif port == self.send_port1:
                    return frame_size_tc5
                else:
                    raise ValueError(f'Unknown timestamp id: 0x{tid:08x}, port: {port}')

            results = self._do_transfer([self.send_port0, self.send_port1], [self.send_port0, self.send_port1, self.recv_port], num_frames)
            self._report_latency(results, [self.send_port0, self.send_port1], self.recv_port, result_dir)
            self._report_bandwidth(results, [self.send_port0, self.send_port1], self.recv_port, size_func, result_dir,
                                   filter_max_tid_by_rstat = True)

def main():
    print(f'Evaluation 5: Measure the latency of a priority flow competing with a best-effort flow.')
    parser = utility.common_argument('Evaluation 5')
    parser.set_defaults(send_port0=0, send_port1=1, recv_port=3)
    parser.add_argument('--tc5_rates', default=[0, 100, 300, 500, 700, 900, 950], type=int, nargs='+', help='TC5 input rate (Mbps)')
    swloader.update_parser(parser)
    args = parser.parse_args()

    # Run test
    tm = TestModule(args)
    for tc5_rate in args.tc5_rates:
        print(f'TC5 rate = {tc5_rate} Mbps')
        tm.test(tc5_rate, f'results/tc5_{tc5_rate:04d}_Mbps')

if __name__ == '__main__':
    main()
