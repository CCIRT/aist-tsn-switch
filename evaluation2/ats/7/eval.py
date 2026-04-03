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

        # Set ProcessingDelayMax to fixed value
        self.ats.set_processing_delay_max(PROCESSING_DELAY_MAX)

        # TCP -> (vlan_id, pcp) mapping
        self.vlan_pcp = {7: (2, 3)}

    def _prepare_ats_param(self, send_port, tc, cir, burst_size):
        src_ip, src_ip_string = get_default_ip(self.crafter, tc, send_port)
        dst_ip, dst_ip_string = get_default_ip(self.crafter, tc, self.recv_port)

        # define the first flow rule for given ip, l4 port pair.
        flow_id = 1
        self.ats.add_flow_rule(send_port, tc, flow_id,
                               src_ip_string, self.src_l4_port,
                               dst_ip_string, self.dst_l4_port)

        # wildcard
        # flow_id = 1
        # self.ats.add_flow_rule(send_port, tc, flow_id,
        #                        "0.0.0.0", 0,
        #                        "0.0.0.0", 0)

        # set ats parameter for this flow
        self.ats.set_ats_param(send_port, tc, flow_id,
                               cir, burst_size)

    def test(self, port0_rate, port0_cir, port1_rate, port1_cir, num_frames, max_residence_time, result_dir):
        # Set MaxResidenceTime to fixed value
        self.ats.set_max_residence_time(self.send_port0, 7, max_residence_time)
        self.ats.set_max_residence_time(self.send_port1, 7, max_residence_time)

        self._prepare_ats_param(self.send_port0, 7, port0_cir, COMMITTED_BURST_SIZE)
        try:
            self._prepare_ats_param(self.send_port1, 7, port1_cir, COMMITTED_BURST_SIZE)
        except ZeroDivisionError:
            # When port1_cir is 0, exception will be raised.
            # Since no frame is sent under this condition, we ignore this exception.
            print(f'Warning: failed to set to CIR {port1_cir}. ZeroDivisionError occurred.')
            pass

        L3L4_HEADER_SIZE = 28
        _, sz7 = self._prepare_frames_with_rate(self.send_port0, self.recv_port, 7, port0_rate, L3L4_HEADER_SIZE)
        _, sz7_2 = self._prepare_frames_with_rate(self.send_port1, self.recv_port, 7, port1_rate, L3L4_HEADER_SIZE)

        send_ports = []
        if port0_rate != 0 and port0_cir != 0:
            send_ports.append(self.send_port0)
        if port1_rate != 0 and port1_cir != 0:
            send_ports.append(self.send_port1)

        stats = self._do_transfer(send_ports, [*send_ports, self.recv_port], num_frames)

        def size_func(tid):
            # The most significant 3 bits are reserved for port id.
            port = tid >> 29

            if port == self.send_port0:
                return sz7
            elif port == self.send_port1:
                return sz7_2
            else:
                raise ValueError(f'Unknown timestamp id: 0x{tid:08x}, port: {port}')

        self._report_latency(stats, send_ports, self.recv_port, result_dir)
        self._report_bandwidth(stats, send_ports, self.recv_port, size_func, result_dir, filter_max_tid_by_rstat = True)


def main():
    print('Evaluation 7: Measure the latency of 2 ATS flows from different ATS scheduler groups to the same traffic class.')
    parser = utility.common_argument('Evaluation 7')
    swloader.update_parser(parser)
    parser.set_defaults(send_port0=0, send_port1=1, recv_port=3)
    parser.add_argument('--port1_cirs', default=[0, 100, 300, 500, 700, 900, 1000], type=int, nargs='+', help='test port1 cirs')
    parser.add_argument('--max_residence_times', default=[134217728], type=int, nargs='+', help='test max residence times')
    args = parser.parse_args()

    tm = TestModule(args)
    for mrt in args.max_residence_times:
        for port1_cir in args.port1_cirs:
            port0_rate = 97
            port0_cir = 100
            port1_rate = 1000

            # port0: 97 Mbps (TC7)
            # port1: 1000 Mbps (TC7), but bound by CIR.

            if port1_cir == 0:
                num_frames = 1000
            else:
                num_frames = int(1000 * (port0_rate + port1_cir) / port0_rate)
            print(f'Port 0: rate = {port0_rate} Mbps, CIR = {port0_cir} Mbps. Port 1: rate = {port1_rate} Mbps, CIR = {port1_cir}, num_frames = {num_frames}, MRT = {mrt/1000:.3f} ns')
            tm.test(port0_rate, port0_cir, port1_rate, port1_cir, num_frames, mrt, f'results/mrt_{mrt}_tc7_CIR{port1_cir}')


if __name__ == '__main__':
    main()
