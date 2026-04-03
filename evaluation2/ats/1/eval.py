# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import ats_switch
import os
import sys
import tsn_efcc

sys.path.append('../common_script')
from ats_default_params import PROCESSING_DELAY_MAX, MAX_RESIDENCE_TIME, COMMITTED_BURST_SIZE
import ats_switch_loader as swloader

sys.path.append('../../cbs/common_script')
import utility
from network_defines import get_default_ip, get_default_mac

SRC_L4_PORT = 0xc000
DST_L4_PORT = 1234


class TestModule(utility.TestModuleBase):
    def __init__(self, args):
        super().__init__(args)
        self.ats = swloader.open_ats_switch(self.xsdb, self.args.switch_jtag_target, args)
        self.send_port = self.args.send_port
        self.recv_port = self.args.recv_port

        dst_mac, _ = get_default_mac(self.crafter, self.recv_port)
        src_mac, _ = get_default_mac(self.crafter, self.send_port)
        utility.learn_fdb(self.crafter, src_mac, dst_mac, self.send_port, self.recv_port)

        # default -> TC5, PCP2 -> TC6, PCP3 -> TC7
        self.ats.set_traffic_class(ats_switch.DEFAULT_PRIO, 5)
        self.ats.set_traffic_class(2, 6)
        self.ats.set_traffic_class(3, 7)

        # Set MaxResidenceTime to fixed value (134,217,728 ps)
        self.ats.set_max_residence_time(self.send_port, 6, 134217728)
        self.ats.set_max_residence_time(self.send_port, 7, 134217728)

    def _prepare_ats_param(self, tc, cir):
        _, src_ip_string = get_default_ip(self.crafter, tc, self.send_port)
        _, dst_ip_string = get_default_ip(self.crafter, tc, self.recv_port)

        # define flow rule for given ip, l4 port pair.
        flow_id = 1
        self.ats.add_flow_rule(self.send_port, tc, flow_id,
                               src_ip_string, SRC_L4_PORT,
                               dst_ip_string, DST_L4_PORT)

        # set ats parameter for this flow
        self.ats.set_ats_param(self.send_port, tc, flow_id,
                               cir, COMMITTED_BURST_SIZE)

    def _prepare_frames(self, tc, length):
        # Since input length is whole frame length,
        # modify this value to payload length
        length -= 28 # ip(20) + udp(8)

        dst_mac, _ = get_default_mac(self.crafter, self.recv_port)
        src_mac, _ = get_default_mac(self.crafter, self.send_port)
        src_ip, _ = get_default_ip(self.crafter, tc, self.send_port)
        dst_ip, _ = get_default_ip(self.crafter, tc, self.recv_port)

        valid_frame = tsn_efcc.Frame('valid_frame').ether(dst_mac, src_mac).ipv4(dst_ip, src_ip).udp(DST_L4_PORT, SRC_L4_PORT).payload(length)
        if tc == 6:
            valid_frame.vlan(1, 2)
        elif tc == 7:
            valid_frame.vlan(1, 3)

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

    def test(self, tc, cir, length, num_frames, result_dir, pdm=PROCESSING_DELAY_MAX):
        self.ats.set_processing_delay_max(pdm)

        if tc >= 6:
            self._prepare_ats_param(tc, cir)
        self._prepare_frames(tc, length)

        stats = self._do_transfer([self.send_port], [self.send_port, self.recv_port], num_frames)
        self._report_latency(stats, [self.send_port], self.recv_port, result_dir)


def run_eval1(args):
    print('Evaluation 1: Measure the basic latency of the network switch.')
    # Run test
    tcs = [5, 7]
    cirs = [10, 100]
    print(f'tcs = {tcs}')
    print(f'cirs = {cirs}')
    print(f'size = {args.frame_sizes}')
    tm = TestModule(args)
    for tc in tcs:
        if tc == 5:
            for sz in args.frame_sizes:
                print(f'tc = {tc}, size = {sz}')
                tm.test(tc, None, sz, args.num_frames, f'results/tc{tc}_sz{sz:04d}')
            continue

        for cir in cirs:
            for sz in args.frame_sizes:
                print(f'tc = {tc}, CIR = {cir} Mbps, size = {sz}')
                tm.test(tc, cir, sz, args.num_frames, f'results/tc{tc}_cir{cir}_sz{sz:04d}')

def run_eval1F(args):
    print('Evaluation 1F: Measure the best ProcessingDelayMax (PDM) value')
    pdms_us = [0, 10, 13, 20]
    pdms = [pdm_us * 1000000 for pdm_us in pdms_us]

    tc = 7
    cir = 100
    tm = TestModule(args)
    for pdm in pdms:
        for sz in args.frame_sizes:
            pdm_us = int(pdm / 1000000)
            print(f'tc = {tc}, CIR = {cir} Mbps, size = {sz}, PDM = {pdm}')
            tm.test(tc, cir, sz, args.num_frames, f'results/tc{tc}_cir{cir}_sz{sz:04d}_pdm{pdm_us}us', pdm)


def main():
    parser = utility.common_argument('Evaluation 1')
    swloader.update_parser(parser)
    parser.set_defaults(send_port=2, recv_port=3)
    parser.add_argument('--frame_sizes', default=[64, 100, 300, 500, 700, 900, 1100, 1300, 1500], type=int, nargs='+', help='test frame sizes')
    parser.add_argument('--num_frames', default=1000, type=int, help='the number of test frames')
    parser.add_argument('--disable-eval1', action='store_true', help='do evaluation 1.')
    parser.add_argument('--disable-eval1F', action='store_true', help='do evaluation 1F.')
    args = parser.parse_args()

    if not args.disable_eval1:
        run_eval1(args)

    if not args.disable_eval1F:
        run_eval1F(args)


if __name__ == '__main__':
    main()
