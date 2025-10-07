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

        # Set ProcessingDelayMax to fixed value
        self.ats.set_processing_delay_max(PROCESSING_DELAY_MAX)

    def _prepare_ats_param(self, tc, cir, burst_size):
        _, src_ip_string = get_default_ip(self.crafter, tc, self.send_port)
        _, dst_ip_string = get_default_ip(self.crafter, tc, self.recv_port)

        # define flow rule for given ip, l3 port pair.
        flow_id = 1
        self.ats.add_flow_rule(self.send_port, tc, flow_id,
                               src_ip_string, SRC_L4_PORT,
                               dst_ip_string, DST_L4_PORT)

        # set ats parameter for this flow
        self.ats.set_ats_param(self.send_port, tc, flow_id,
                               cir, burst_size)

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

        eol_frame = tsn_efcc.Frame.eol()

        # 1 valid frame + eol frame
        self.crafter.set_frame(self.send_port, 0, valid_frame)
        self.crafter.set_frame(self.send_port, 1, eol_frame)

        if self.args.show_test_sequence:
            frames = self.crafter.get_frames(self.send_port)
            print('==== Test sequence ====')
            print(frames[0])
            print(frames[1])
            print('=======================')

    def test(self, tc, cir, length, num_burst, max_residence_time, result_dir):
        self.ats.set_max_residence_time(self.send_port, 7, max_residence_time)

        if tc >= 6:
            self._prepare_ats_param(tc, cir, num_burst * length)
        self._prepare_frames(tc, length)

        num_frames = 100
        stats = self._do_transfer([self.send_port], [self.send_port, self.recv_port], num_frames)
        self._report_latency(stats, [self.send_port], self.recv_port, result_dir)


def main():
    print('Evaluation 2: Confirm the capability of ATS to control the burst size of a flow.')
    parser = utility.common_argument('Evaluation 2')
    swloader.update_parser(parser)
    parser.set_defaults(send_port=2, recv_port=3)
    parser.add_argument('--num_bursts', default=[1, 2, 4, 8, 16, 32, 48, 64], type=int, nargs='+', help='test frame burst sizes')
    parser.add_argument('--max_residence_times', default=[50 * 1000 * 1000, 4294967295], type=int, nargs='+', help='test max residence time')
    args = parser.parse_args()

    tm = TestModule(args)
    tc = 7
    cir = 100
    sz = 1522
    for max_residence_time in args.max_residence_times:
        for num_burst in args.num_bursts:
            print(f'tc = {tc}, CIR = {cir} Mbps, CBS: {num_burst} frames, size = {sz}, max_residence_time: {max_residence_time / 1000000:.6f} us')
            tm.test(tc, cir, sz, num_burst, max_residence_time, f'results/burst_{num_burst}_max_residence_time_{max_residence_time}')


if __name__ == '__main__':
    main()
