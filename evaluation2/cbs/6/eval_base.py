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
        self.send_port2 = self.args.send_port2
        self.recv_port = self.args.recv_port

        dst_mac, _ = get_default_mac(self.crafter, self.recv_port)
        src_mac0, _ = get_default_mac(self.crafter, self.send_port0)
        src_mac1, _ = get_default_mac(self.crafter, self.send_port1)
        src_mac2, _ = get_default_mac(self.crafter, self.send_port2)
        utility.learn_fdb(self.crafter, src_mac0, dst_mac, self.send_port0, self.recv_port)
        utility.learn_fdb(self.crafter, src_mac1, dst_mac, self.send_port1, self.recv_port)
        utility.learn_fdb(self.crafter, src_mac2, dst_mac, self.send_port2, self.recv_port)

        # TCP -> (vlan_id, pcp) mapping
        self.vlan_pcp = {5: (None, None),
                         6: (1, 2),
                         7: (2, 3)}
        for tc, (vlan, pcp) in self.vlan_pcp.items():
            if pcp is not None:
                self.cbs.set_traffic_class(pcp, tc)

        # set slope to 100 Mbps for TC6 and TC7
        idle_slope =   100 * 1000
        send_slope = -1000 * 1000 + idle_slope
        self.cbs.set_slope(6, idle_slope, send_slope)
        self.cbs.set_slope(7, idle_slope, send_slope)

    def test(self, tc5_rate, tc6_rate, tc7_rate, num_frames, result_dir):
        print(f'Start test. tc5_rate={tc5_rate} Mbps, tc6_rate = {tc6_rate} Mbps, tc7_rate = {tc7_rate} Mbps, num_frames = {num_frames}, result_dir = {result_dir}')
        enabled_ports = []
        frame_size = {}

        if tc5_rate != 0:
            port = self.send_port0
            _, sz = self._prepare_frames_with_rate(port, self.recv_port, 5, tc5_rate)
            frame_size[port] = sz
            enabled_ports.append(port)

        if tc6_rate != 0:
            port = self.send_port1
            _, sz = self._prepare_frames_with_rate(port, self.recv_port, 6, tc6_rate)
            frame_size[port] = sz
            enabled_ports.append(port)

        if tc7_rate != 0:
            port = self.send_port2
            _, sz = self._prepare_frames_with_rate(port, self.recv_port, 7, tc7_rate)
            frame_size[port] = sz
            enabled_ports.append(port)

        results = self._do_transfer(enabled_ports, [*enabled_ports, self.recv_port], num_frames)
        self._report_latency(results, enabled_ports, self.recv_port, result_dir)

        def size_func(tid):
            # The most significant 3 bits are reserved for port id.
            port = tid >> 29
            return frame_size[port]

        self._report_bandwidth(results, enabled_ports, self.recv_port, size_func, result_dir,
                               filter_max_tid_by_rstat = True)
