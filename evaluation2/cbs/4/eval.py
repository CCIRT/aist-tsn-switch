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
        self.vlan_pcp = {4: (1, 2),
                         5: (2, 3),
                         7: (3, 4)}
        for tc in self.vlan_pcp.keys():
            self.cbs.set_traffic_class(self.vlan_pcp[tc][1], tc)

    def limit_rate(self, tc, rate):
        idle_slope = rate * 1000
        send_slope = idle_slope - 1000000
        self.cbs.set_slope(tc, idle_slope, send_slope)

    def test(self, num_frames, port0_tc, port0_rate, port1_tc, port1_rate, result_dir):
        _, frame_size0 = self._prepare_frames_with_rate(self.send_port0, self.recv_port, port0_tc, port0_rate)
        _, frame_size1 = self._prepare_frames_with_rate(self.send_port1, self.recv_port, port1_tc, port1_rate)

        if port0_rate == 0:
            # run 1 port
            results = self._do_transfer([self.send_port1], [self.send_port1, self.recv_port], num_frames)
            self._report_latency(results, [self.send_port1], self.recv_port, result_dir)
            self._report_bandwidth(results, [self.send_port1], self.recv_port, lambda x: frame_size1, result_dir)
        else:
            # run 2 ports
            def size_func(tid):
                # The most significant 3 bits are reserved for port id.
                port = tid >> 29

                if port == self.send_port0:
                    return frame_size0
                elif port == self.send_port1:
                    return frame_size1
                else:
                    raise ValueError(f'Unknown timestamp id: 0x{tid:08x}, port: {port}')

            results = self._do_transfer([self.send_port0, self.send_port1], [self.send_port0, self.send_port1, self.recv_port], num_frames)
            self._report_latency(results, [self.send_port0, self.send_port1], self.recv_port, result_dir)
            self._report_bandwidth(results, [self.send_port0, self.send_port1], self.recv_port, size_func, result_dir,
                                   filter_max_tid_by_rstat = True)


def main():
    print(f'Evaluation 4: Confirm strict priority control among traffic classes.')
    parser = utility.common_argument('Evaluation 4')
    parser.set_defaults(send_port0=0, send_port1=1, recv_port=3)
    parser.add_argument('--rates', default=[0, 200, 400, 600, 800, 1000], type=int, nargs='+', help='test rates')
    parser.add_argument('--num_frames', default=1000, type=int, help='the number of test frames')
    swloader.update_parser(parser)
    args = parser.parse_args()

    # Run test
    tm = TestModule(args)
    print('Test1: tc5 and tc4')
    tc0 = 5
    tc1 = 4
    rate1 = 1000
    for rate0 in args.rates:
        print(f'Port0: (rate [Mbps], tc) = ({rate0}, {tc0})')
        print(f'Port1: (rate [Mbps], tc) = ({rate1}, {tc1})')
        tm.test(args.num_frames, tc0, rate0, tc1, rate1, f'results/tc{tc0}_{rate0}_tc{tc1}_{rate1}')

    print('Test2: tc5 and tc5')
    tc0 = 5
    tc1 = 5
    rate1 = 1000
    for rate0 in args.rates:
        print(f'Port0: (rate [Mbps], tc) = ({rate0}, {tc0})')
        print(f'Port1: (rate [Mbps], tc) = ({rate1}, {tc1})')
        tm.test(args.num_frames, tc0, rate0, tc1, rate1, f'results/tc{tc0}_{rate0}_tc{tc1}_{rate1}')

    print('Test3: tc7 and tc5 (CBS no limit)')
    tc0 = 7
    tc1 = 5
    rate1 = 1000
    for rate0 in args.rates:
        print(f'Port0: (rate [Mbps], tc) = ({rate0}, {tc0})')
        print(f'Port1: (rate [Mbps], tc) = ({rate1}, {tc1})')
        tm.limit_rate(tc0, 1000)
        tm.test(args.num_frames, tc0, rate0, tc1, rate1, f'results/tc{tc0}_{rate0}_tc{tc1}_{rate1}')

    print('Test4: tc7 and tc5 (CBS with limit)')
    tc0 = 7
    tc1 = 5
    for rate0 in args.rates:
        print(f'Port0: (rate [Mbps], tc) = ({rate0}, {tc0})')
        print(f'Port1: (rate [Mbps], tc) = ({rate1}, {tc1})')
        tm.limit_rate(tc0, rate0)
        tm.test(args.num_frames, tc0, rate0, tc1, rate1, f'results/tc{tc0}_{rate0}_tc{tc1}_{rate1}_with_cbs')


if __name__ == '__main__':
    main()
