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

class TestModule(utility.TestModuleBase):
    def __init__(self, args):
        super().__init__(args)
        self.ats = swloader.open_ats_switch(self.xsdb, self.args.switch_jtag_target, args)

        self.send_port = self.args.send_port
        self.recv_port = self.args.recv_port

        dst_mac, _ = get_default_mac(self.crafter, self.recv_port)
        src_mac, _ = get_default_mac(self.crafter, self.send_port)
        utility.learn_fdb(self.crafter, src_mac, dst_mac, self.send_port, self.recv_port)

        self.src_l4_port = 1234
        self.dst_l4_ports = (5201, 5202)

        # default -> TC5, PCP2 -> TC6, PCP3 -> TC7
        self.ats.set_traffic_class(ats_switch.DEFAULT_PRIO, 5)
        self.ats.set_traffic_class(2, 6)
        self.ats.set_traffic_class(3, 7)

        # Set MaxResidenceTime to fixed value
        self.ats.set_max_residence_time(self.send_port, 7, MAX_RESIDENCE_TIME)

        # Set ProcessingDelayMax to fixed value
        self.ats.set_processing_delay_max(PROCESSING_DELAY_MAX)

    def _prepare_ats_param(self, tc, cirs, burst_size):
        _, src_ip_string = get_default_ip(self.crafter, tc, self.send_port)
        _, dst_ip_string = get_default_ip(self.crafter, tc, self.recv_port)

        # define the first flow rule for given ip, l4 port pair.
        flow_id = 1
        self.ats.add_flow_rule(self.send_port, tc, flow_id,
                               src_ip_string, self.src_l4_port,
                               dst_ip_string, self.dst_l4_ports[0])

        # set ats parameter for this flow
        self.ats.set_ats_param(self.send_port, tc, flow_id,
                               cirs[0], burst_size)

        # define the second flow rule for given ip, l4 port pair.
        flow_id += 1
        self.ats.add_flow_rule(self.send_port, tc, flow_id,
                               src_ip_string, self.src_l4_port,
                               dst_ip_string, self.dst_l4_ports[1])

        # set ats parameter for this flow
        self.ats.set_ats_param(self.send_port, tc, flow_id,
                               cirs[1], burst_size)

    def _prepare_frames(self, tc, length):
        # Since input length is whole frame length,
        # modify this value to payload length
        length -= 28 # ip(20) + udp(8)

        src_mac, _ = get_default_mac(self.crafter, self.send_port)
        dst_mac, _ = get_default_mac(self.crafter, self.recv_port)
        src_ip, _ = get_default_ip(self.crafter, tc, self.send_port)
        dst_ip, _ = get_default_ip(self.crafter, tc, self.recv_port)

        frame0 = tsn_efcc.Frame('frame1').ether(dst_mac, src_mac).ipv4(dst_ip, src_ip).udp(self.dst_l4_ports[0], self.src_l4_port).payload(length)
        if tc == 6:
            frame0.vlan(1, 2)
        elif tc == 7:
            frame0.vlan(1, 3)

        # The only difference between frame0 and frame1 is destination L4 port.
        frame1 = frame0.clone('frame1').udp(self.dst_l4_ports[1], self.src_l4_port)
        eol_frame = tsn_efcc.Frame.eol()

        # L2 application length
        frame_size = frame0.get_length()[0]

        # Send frame0 and frame1 one by one.
        self.crafter.set_frame(self.send_port, 0, frame0)
        self.crafter.set_frame(self.send_port, 1, frame1)
        self.crafter.set_frame(self.send_port, 2, eol_frame)

        if self.args.show_test_sequence:
            frames = self.crafter.get_frames(self.send_port)
            print('==== Test sequence ====')
            print(frames[0])
            print(frames[1])
            print(frames[2])
            print('=======================')

        return frame_size

    def test(self, tc, cirs, length, num_frames, result_dir):
        if tc >= 6:
            self._prepare_ats_param(tc, cirs, COMMITTED_BURST_SIZE)
        frame_size = self._prepare_frames(tc, length)

        stats = self._do_transfer([self.send_port], [self.send_port, self.recv_port], num_frames)

        # Since this evaluation send 2 test patterns in a single port, we modify stats for 2 ports.
        logical_send_ports = (0, 1)
        new_stats = {self.recv_port: stats[self.recv_port]}

        for port in logical_send_ports:
            # We can distinguish by timestamp id which logical port the frame is sent from.
            new_send_stat = stats[self.send_port].filter(lambda tid: tid % 2 == port)
            new_stats[port] = new_send_stat

        self._report_latency(new_stats, logical_send_ports, self.recv_port, result_dir)
        self._report_bandwidth(new_stats, logical_send_ports, self.recv_port, lambda x: frame_size, result_dir, filter_max_tid_by_rstat = False)


def main():
    print(f'Evaluation 4')
    parser = utility.common_argument('Evaluation 4')
    swloader.update_parser(parser)
    parser.set_defaults(send_port=2, recv_port=3)
    parser.add_argument('--frame_size', default=1500, type=int, help='test frame sizes')
    parser.add_argument('--cirs', default=[100, 200], type=int, nargs='+', help='CIRs for each flow')
    parser.add_argument('--num_frames', default=3000, type=int, help='the number of test frames')
    args = parser.parse_args()

    tc = 7
    tm = TestModule(args)
    cirs_str = '_'.join([str(cir) for cir in args.cirs])
    print(f'tc = {tc}, CIRs = {args.cirs} Mbps')
    tm.test(tc, args.cirs, args.frame_size, args.num_frames, f'results/cirs_{cirs_str}')


if __name__ == '__main__':
    main()
