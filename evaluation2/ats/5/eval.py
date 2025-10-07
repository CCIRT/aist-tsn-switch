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

        self.send_port0 = self.args.send_port0
        self.send_port1 = self.args.send_port1
        self.recv_port = self.args.recv_port

        dst_mac, _ = get_default_mac(self.crafter, self.recv_port)
        src_mac0, _ = get_default_mac(self.crafter, self.send_port0)
        src_mac1, _ = get_default_mac(self.crafter, self.send_port1)
        utility.learn_fdb(self.crafter, src_mac0, dst_mac, self.send_port0, self.recv_port)
        utility.learn_fdb(self.crafter, src_mac1, dst_mac, self.send_port1, self.recv_port)

        self.src_l4_port = 1234
        self.dst_l4_port = 5201

        # default -> TC5, PCP2 -> TC6, PCP3 -> TC7
        self.ats.set_traffic_class(ats_switch.DEFAULT_PRIO, 5)
        self.ats.set_traffic_class(2, 6)
        self.ats.set_traffic_class(3, 7)

        # Set MaxResidenceTime to fixed value
        self.ats.set_max_residence_time(self.send_port0, 7, MAX_RESIDENCE_TIME)
        self.ats.set_max_residence_time(self.send_port1, 7, MAX_RESIDENCE_TIME)

        # Set ProcessingDelayMax to fixed value
        self.ats.set_processing_delay_max(PROCESSING_DELAY_MAX)

        # TCP -> (vlan_id, pcp) mapping
        self.vlan_pcp = {5: (None, None),
                         7: (2, 3)}

    def _prepare_ats_param(self, send_port, tc, cir, burst_size):
        _, src_ip_string = get_default_ip(self.crafter, tc, send_port)
        _, dst_ip_string = get_default_ip(self.crafter, tc, self.recv_port)

        # define the first flow rule for given ip, l4 port pair.
        flow_id = 1
        self.ats.add_flow_rule(send_port, tc, flow_id,
                               src_ip_string, self.src_l4_port,
                               dst_ip_string, self.dst_l4_port)

        # set ats parameter for this flow
        self.ats.set_ats_param(send_port, tc, flow_id,
                               cir, burst_size)

    def test(self, tc5_rate, tc7_rate, num_frames, result_dir):
        self._prepare_ats_param(self.send_port0, 7, 1000, COMMITTED_BURST_SIZE)
        _, sz7 = self._prepare_frames_with_rate(self.send_port0, self.recv_port, 7, tc7_rate)
        _, sz5 = self._prepare_frames_with_rate(self.send_port1, self.recv_port, 5, tc5_rate)

        if tc7_rate == 0:
            send_ports = [self.send_port1]
        else:
            send_ports = [self.send_port0, self.send_port1]

        stats = self._do_transfer(send_ports, [*send_ports, self.recv_port], num_frames)

        def size_func(tid):
            # The most significant 3 bits are reserved for port id.
            port = tid >> 29

            if port == self.send_port0:
                return sz7
            elif port == self.send_port1:
                return sz5
            else:
                raise ValueError(f'Unknown timestamp id: 0x{tid:08x}, port: {port}')

        self._report_latency(stats, send_ports, self.recv_port, result_dir)
        self._report_bandwidth(stats, send_ports, self.recv_port, size_func, result_dir, filter_max_tid_by_rstat = True)


def main():
    print(f'Evaluation 5')
    parser = utility.common_argument('Evaluation 5')
    swloader.update_parser(parser)
    parser.set_defaults(send_port0=0, send_port1=1, recv_port=3)
    parser.add_argument('--tc7_rates', default=[0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000], type=int, nargs='+', help='test tc7 rates')
    parser.add_argument('--num_frames', default=1000, type=int, help='the number of test frames')
    args = parser.parse_args()

    tm = TestModule(args)
    for tc7_rate in args.tc7_rates:
        tc5_rate = 1000
        print(f'tc7_rate = {tc7_rate} Mbps, tc5_rate = {tc5_rate} Mbps')
        tm.test(tc5_rate, tc7_rate, args.num_frames, f'results/tc7_{tc7_rate}_tc5_{tc5_rate}')


if __name__ == '__main__':
    main()
