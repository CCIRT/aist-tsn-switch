# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import cbs_switch
import copy
import math
import numpy as np
import os
import pyxsdb
import sys
import tsn_efcc

sys.path.append('../common_script')
import utility
from network_defines import get_default_mac, get_default_ip
import cbs_switch_loader as swloader


# Minimum interval between frames
FRAME_INTERVAL = 24 # ifg(12) + preamble(8) + fcs(4)

# eth(14) + vlan(4) + ip(20) + udp(8)
HEADER_SIZE = 46

MAX_NUM_FRAMES = 1024

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

    def _prepare_frames(self, num_frames, tc, average_rate_mbps, stddev):
        # Since input length is whole frame length,
        # modify this value to payload length
        length = 1500
        length -= 28 # ip(20) + udp(8)

        dst_mac, _ = get_default_mac(self.crafter, self.recv_port)
        src_mac, _ = get_default_mac(self.crafter, self.send_port)
        dst_ip, _ = get_default_ip(self.crafter, tc, self.recv_port)
        src_ip, _ = get_default_ip(self.crafter, tc, self.send_port)

        valid_send_time = length + HEADER_SIZE + FRAME_INTERVAL
        total_send_time = math.ceil(valid_send_time * 1000 / average_rate_mbps)
        nop_send_time = total_send_time - valid_send_time
        print(f'send time: total {total_send_time} cycles, valid: {valid_send_time} cycles, nop: {nop_send_time} cycles')

        # create random crafter
        random_nop_times = np.random.normal(loc=nop_send_time, scale=stddev, size=num_frames)
        print(f'random_nop_times: avg={np.mean(random_nop_times)}, stddev={np.std(random_nop_times)}, min={np.amin(random_nop_times)}, max={np.amax(random_nop_times)}')

        idx = 0
        valid_frame = tsn_efcc.Frame('valid_frame')
        valid_frame.ether(dst_mac, src_mac).vlan(1, 3).ipv4(dst_ip, src_ip).udp(1234, 0xc000).payload(length)

        max_nop_time = 0xffff + HEADER_SIZE + FRAME_INTERVAL
        for nt in random_nop_times:
            nt = round(nt)
            nop_length = nt - HEADER_SIZE - FRAME_INTERVAL

            if nop_length >= max_nop_time or nop_length < 0:
                raise ValueError('Error: nop frame size({nop_length}) exceed max_nop_time({max_nop_time}) or less than 0. Please consider to increase average rate or reduce stddev')
                raise ValueError('Expected frame length ')


            self.crafter.set_frame(self.send_port, idx, valid_frame)
            idx += 1
            self.crafter.set_frame(self.send_port, idx, valid_frame.clone().payload(nop_length).nop())
            idx += 1

        # eol frame
        eol_frame = tsn_efcc.Frame.eol()
        self.crafter.set_frame(self.send_port, idx, eol_frame)
        idx += 1

        if idx >= MAX_NUM_FRAMES:
            raise ValueError(f'The number of frames exceeds the buffer size of ef_crafter. Please consider to (1) increase average rate or (2) reduce num frames. current_index={idx}, buffer_size={MAX_NUM_FRAMES}')

        print(f'total # of frames = {idx}, # of valid frames = {len(random_nop_times)}')

        if self.args.show_test_sequence:
            frames = self.crafter.get_frames(self.send_port, max_num = 30)
            print('==== Test sequence ====')
            for frame in frames:
                print(frame)
            print('...')
            print('=======================')

    def test(self, num_frames, avg_rate, stddev, result_dir):
        # slope (TC7): idle =  10000 Kbps, send = -990000 Kbps
        tc = 7
        idle_slope = avg_rate * 1000
        send_slope = idle_slope - 1000000
        print(f'idle_slope = {idle_slope}, send_slope = {send_slope}')
        self.cbs.set_slope(tc, idle_slope, send_slope)

        self._prepare_frames(num_frames, tc, avg_rate, stddev)
        results = self._do_transfer([self.send_port], [self.send_port, self.recv_port], num_frames)
        self._report_latency(results, [self.send_port], self.recv_port, result_dir)


def main():
    print(f'Evaluation 3: Confirm the capability of a CBS traffic class to adjust frame intervals.')
    parser = utility.common_argument('Evaluation 3')
    parser.set_defaults(send_port=2, recv_port=3)
    parser.add_argument('--num_frames', default=500, type=int, help='the number of test frames')
    parser.add_argument('--avg_rate_mbps', default=250, type=int, help='the average network rate')
    parser.add_argument('--stddev_cycles', default=1000, type=int, help='the standard deviation of frame interval (cycles)')
    swloader.update_parser(parser)

    args = parser.parse_args()
    tm = TestModule(args)
    tm.test(args.num_frames, args.avg_rate_mbps, args.stddev_cycles, f'results/rate{args.avg_rate_mbps}_stddev{args.stddev_cycles}')


if __name__ == '__main__':
    main()
