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
        self.send_port = self.args.send_port
        self.recv_port = self.args.recv_port

        dst_mac, _ = get_default_mac(self.crafter, self.recv_port)
        src_mac, _ = get_default_mac(self.crafter, self.send_port)
        utility.learn_fdb(self.crafter, src_mac, dst_mac, self.args.send_port, self.args.recv_port)

        # default -> TC5, PCP2 -> TC6, PCP3 -> TC7
        self.cbs.set_traffic_class(cbs_switch.DEFAULT_PRIO, 5)
        self.cbs.set_traffic_class(2, 6)
        self.cbs.set_traffic_class(3, 7)

        # slope (TC6): idle = 100000 Kbps, send = -900000 Kbps
        # slope (TC7): idle =  10000 Kbps, send = -990000 Kbps
        self.cbs.set_slope(6, 100000, -900000)
        self.cbs.set_slope(7,  10000, -990000)

    def _prepare_frames(self, tc, length):
        # Since input length is whole frame length,
        # modify this value to payload length
        length -= 28 # ip(20) + udp(8)

        dst_mac, _ = get_default_mac(self.crafter, self.recv_port)
        src_mac, _ = get_default_mac(self.crafter, self.send_port)
        dst_ip, _ = get_default_ip(self.crafter, tc, self.recv_port)
        src_ip, _ = get_default_ip(self.crafter, tc, self.send_port)

        valid_frame = tsn_efcc.Frame('valid_frame')
        if tc == 5:
            valid_frame.ether(dst_mac, src_mac).ipv4(4, 3).udp(1234, 0xc000).payload(length)
        elif tc == 6:
            valid_frame.ether(dst_mac, src_mac).vlan(1, 2).ipv4(dst_ip, src_ip).udp(1234, 0xc000).payload(length)
        elif tc == 7:
            valid_frame.ether(dst_mac, src_mac).vlan(1, 3).ipv4(dst_ip, src_ip).udp(1234, 0xc000).payload(length)

        nop_frame = valid_frame.clone('nop_frame').nop()
        eol_frame = tsn_efcc.Frame.eol()

        # 1 valid frame + 199 nop frames + eol frames (eol frames size is ignored)
        self.crafter.set_frame(self.send_port, 0, valid_frame)
        for i in range(1, 200):
            self.crafter.set_frame(self.send_port, i, nop_frame)
        self.crafter.set_frame(self.send_port, 200, eol_frame)

        if self.args.show_test_sequence:
            frames = self.crafter.get_frames(self.send_port)
            print('==== Test sequence ====')
            print(frames[0])
            print(frames[1])
            print(frames[2])
            print('...')
            print(frames[-2])
            print(frames[-1])
            print('=======================')


    def test(self, tc, length, num_frames, result_dir):
        self._prepare_frames(tc, length)
        results = self._do_transfer([self.send_port], [self.send_port, self.recv_port], num_frames)
        self._report_latency(results, [self.send_port], self.recv_port, result_dir)


def main():
    print(f'Evaluation 2: Measure the basic latency of the network switch.')
    parser = utility.common_argument('Evaluation 2')
    parser.set_defaults(send_port=2, recv_port=3)
    parser.add_argument('--tcs', default=[5, 6, 7], type=int, nargs='+', help='test tcs')
    parser.add_argument('--frame_sizes', default=[64, 100, 300, 500, 700, 900, 1100, 1300, 1500], type=int, nargs='+', help='test frame sizes')
    parser.add_argument('--num_frames', default=1000, type=int, help='the number of test frames')
    swloader.update_parser(parser)
    args = parser.parse_args()

    # Run test
    print(f'tcs = {args.tcs}')
    print(f'size = {args.frame_sizes}')
    tm = TestModule(args)
    for tc in args.tcs:
        for sz in args.frame_sizes:
            print(f'tc = {tc}, size = {sz}')
            tm.test(tc, sz, args.num_frames, f'results/tc{tc}_sz{sz:04d}')


if __name__ == '__main__':
    main()
