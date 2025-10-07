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

# fixed value
PROCESSING_DELAY_MAX = 26000000
MAX_RESIDENCE_TIME = 134217728
COMMITTED_BURST_SIZE = 1542

class TestModule(utility.TestModuleBase):
    def __init__(self, args):
        super().__init__(args)
        self.ats = swloader.open_ats_switch(self.xsdb, self.args.switch_jtag_target, args)

        self.send_port0 = self.args.send_port0
        self.send_port1 = self.args.send_port1
        self.send_port2 = self.args.send_port2
        self.recv_port = self.args.recv_port

        dst_mac, _ = get_default_mac(self.crafter, self.recv_port)
        src_mac0, _ = get_default_mac(self.crafter, self.send_port0)
        src_mac1, _ = get_default_mac(self.crafter, self.send_port1)
        src_mac2, _ = get_default_mac(self.crafter, self.send_port2)
        utility.learn_fdb(self.crafter, src_mac0, dst_mac, self.send_port0, self.recv_port)
        utility.learn_fdb(self.crafter, src_mac1, dst_mac, self.send_port1, self.recv_port)
        utility.learn_fdb(self.crafter, src_mac2, dst_mac, self.send_port2, self.recv_port)

        self.src_l4_port = 1234
        self.dst_l4_port = 5201

        # default -> TC5, PCP2 -> TC6, PCP3 -> TC7
        self.ats.set_traffic_class(ats_switch.DEFAULT_PRIO, 5)
        self.ats.set_traffic_class(2, 6)
        self.ats.set_traffic_class(3, 7)

        # Set MaxResidenceTime to fixed value
        self.ats.set_max_residence_time(self.send_port0, 7, MAX_RESIDENCE_TIME)
        self.ats.set_max_residence_time(self.send_port1, 7, MAX_RESIDENCE_TIME)
        self.ats.set_max_residence_time(self.send_port2, 7, MAX_RESIDENCE_TIME)
        self.ats.set_max_residence_time(self.send_port0, 6, MAX_RESIDENCE_TIME)
        self.ats.set_max_residence_time(self.send_port1, 6, MAX_RESIDENCE_TIME)
        self.ats.set_max_residence_time(self.send_port2, 6, MAX_RESIDENCE_TIME)

        # Set ProcessingDelayMax to fixed value
        self.ats.set_processing_delay_max(PROCESSING_DELAY_MAX)

        # TCP -> (vlan_id, pcp) mapping
        self.vlan_pcp = {5: (None, None),
                         6: (1, 2),
                         7: (2, 3)}

    def _prepare_ats_param(self, send_port, tc, cir, burst_size):
        src_ip, src_ip_string = get_default_ip(self.crafter, tc, send_port)
        dst_ip, dst_ip_string = get_default_ip(self.crafter, tc, self.recv_port)

        # define the first flow rule for given ip, l4 port pair.
        flow_id = 1
        self.ats.add_flow_rule(send_port, tc, flow_id,
                               src_ip_string, self.src_l4_port,
                               dst_ip_string, self.dst_l4_port)

        # set ats parameter for this flow
        self.ats.set_ats_param(send_port, tc, flow_id,
                               cir, burst_size)

    def test(self, tc7_rate, tc7_cir, tc6_rate, tc6_cir, tc5_rate, num_frames, result_dir):
        print(f'tc7_rate: {tc7_rate} Mbps, tc6_rate: {tc6_rate} Mbps, tc5_rate: {tc5_rate} Mbps')

        self._prepare_ats_param(self.send_port0, 7, tc7_cir, COMMITTED_BURST_SIZE)
        self._prepare_ats_param(self.send_port1, 6, tc6_cir, COMMITTED_BURST_SIZE)

        L3L4_HEADER_SIZE = 28
        _, sz7 = self._prepare_frames_with_rate(self.send_port0, self.recv_port, 7, tc7_rate, L3L4_HEADER_SIZE)
        _, sz6 = self._prepare_frames_with_rate(self.send_port1, self.recv_port, 6, tc6_rate, L3L4_HEADER_SIZE)
        _, sz5 = self._prepare_frames_with_rate(self.send_port2, self.recv_port, 5, tc5_rate, L3L4_HEADER_SIZE)

        send_ports = []
        if tc7_rate != 0:
            send_ports.append(self.send_port0)
        if tc6_rate != 0:
            send_ports.append(self.send_port1)
        if tc5_rate != 0:
            send_ports.append(self.send_port2)

        stats = self._do_transfer(send_ports, [*send_ports, self.recv_port], num_frames)

        def size_func(tid):
            # The most significant 3 bits are reserved for port id.
            port = tid >> 29
            if port == self.send_port0:
                return sz7
            elif port == self.send_port1:
                return sz6
            elif port == self.send_port2:
                return sz5
            else:
                raise ValueError(f'Unknown timestamp id: 0x{tid:08x}, port: {port}')

        self._report_latency(stats, send_ports, self.recv_port, result_dir)
        self._report_bandwidth(stats, send_ports, self.recv_port, size_func, result_dir, filter_max_tid_by_rstat = True)


def main():
    print('Evaluation 10: Measure the latency of the 1st priority ATS flow competing with the 2nd priority ATS flow and the best-effort flow.')
    parser = utility.common_argument('Evaluation 10')
    swloader.update_parser(parser)
    parser.set_defaults(send_port0=0, send_port1=1, send_port2=2, recv_port=3)

    args = parser.parse_args()

    tc6_rate = 97
    tc7_cir = 100
    tc6_cir = 100

    tm = TestModule(args)
    print('-------------------------')
    print('Pattern (A): TC6 Only')
    tc7_rate = 0
    tc5_rate = 0
    num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc6_rate)
    tm.test(tc7_rate, tc7_cir, tc6_rate, tc6_cir, tc5_rate, num_frames, 'results/tc6_only')

    print('-------------------------')
    print('Pattern (B): TC6 + TC7')
    tc7_rate = 99
    tc5_rate = 0
    num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc6_rate)
    tm.test(tc7_rate, tc7_cir, tc6_rate, tc6_cir, tc5_rate, num_frames, 'results/tc6_tc7')

    print('-------------------------')
    print('Pattern (C): TC6 + TC5')
    tc7_rate = 0
    tc5_rate = 900
    num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc6_rate)
    tm.test(tc7_rate, tc7_cir, tc6_rate, tc6_cir, tc5_rate, num_frames, 'results/tc6_tc5_900')

    print('-------------------------')
    print('Pattern (D): TC6 + TC7 + TC5')
    tc7_rate = 99
    for tc5_rate in [100, 300, 500, 700, 900]:
        num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc6_rate)
        tm.test(tc7_rate, tc7_cir, tc6_rate, tc6_cir, tc5_rate, num_frames, f'results/tc6_tc7_tc5_{tc5_rate}')


if __name__ == '__main__':
    main()
