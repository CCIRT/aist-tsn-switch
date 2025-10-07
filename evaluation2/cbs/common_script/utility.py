# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import argparse
import numpy as np
import os
import pyxsdb
import tsn_efcc
from network_defines import get_default_mac, get_default_ip

# design-dependent constants
FREQ_MHZ = 125
BITS_PER_CYCLE = 8
MAX_NOP_PAYLOAD = 65535

# constants
FRAME_INTERVAL = 24 # ifg(12) + preamble(8) + fcs(4)
BITS_PER_BYTE = 8
BYTES_PER_CYCLE = BITS_PER_CYCLE / BITS_PER_BYTE
NS_PER_CYCLE = 1000 / FREQ_MHZ
MAX_RATE_MHZ = BITS_PER_CYCLE / NS_PER_CYCLE * 1000

def common_argument(name: str):
    parser = argparse.ArgumentParser(name)
    parser.add_argument('--efcc-jtag-target', default=3, type=int, help='The xsdb target number of AXI JTAG of TSN EFCC.')
    parser.add_argument('--switch-jtag-target', default=9, type=int, help='The xsdb target number of AXI JTAG of CBS/ATS Switch.')
    parser.add_argument('--show-test-sequence', action='store_true', help='If set, show test sequence to stdout')
    parser.add_argument('--device-frequency', type=float, default=125.0, help='Device frequency (MHz) of TSN EFCC')
    parser.add_argument('--efcc-latency-offset', type=int, default=1, help='Timestamp offset applied to sender timestamps. This value is used to reduce the internal latency of TSN-EFCC from total latency')

    return parser


def learn_fdb(crafter: tsn_efcc.EFCrafter, smac_idx: int, dmac_idx: int, sport: int, dport: int):
    """
    Send initialization frames to switch from each port, to learn FDB table.
    :param tsn_efcc.EFCrafter crafter: tsn_efcc object
    :param int smac_idx: source mac index
    :param int dmac_idx: destination mac index
    :param int sport: source port (network port, not a TCP/UDP port.)
    :param int dport: destination port (network port, not a TCP/UDP port.)
    """

    frame0 = tsn_efcc.Frame('Frame0').ether(dmac_idx, smac_idx).ipv4(1, 0).payload(72)
    frame1 = tsn_efcc.Frame('Frame1').ether(smac_idx, dmac_idx).ipv4(2, 1).payload(72)
    eol = tsn_efcc.Frame.eol()

    crafter.set_frame(sport, 0, frame0)
    crafter.set_frame(sport, 1, eol)
    crafter.set_frame(dport, 0, frame1)
    crafter.set_frame(dport, 1, eol)

    # reset crafter
    crafter.reset(0xf)

    # learn mac
    crafter.start((1 << sport) | (1 << dport))

    # wait until transfer done
    crafter.wait(sport)
    crafter.wait(dport)

    # reset crafter
    crafter.reset(0xf)


class TestModuleBase():
    def __init__(self, args):
        self.args = args

        self.xsdb = pyxsdb.PyXsdb()
        self.xsdb.connect()

        addr_table = tsn_efcc.default_tsn_efcc_address_table()

        self.crafter = tsn_efcc.EFCrafter(self.xsdb, self.args.efcc_jtag_target, addr_table)
        self.captures = []
        for i in range(4):
            capture = tsn_efcc.EFCapture(self.xsdb, self.args.efcc_jtag_target,
                                                     addr_table, i)
            self.captures.append(capture)

        # Setup port connections for test
        self.switch = tsn_efcc.AxisNetSwitch(self.xsdb, self.args.efcc_jtag_target, addr_table)
        self.switch.start_config()
        self.switch.connect(4, 0)
        self.switch.connect(5, 1)
        self.switch.connect(6, 2)
        self.switch.connect(7, 3)
        self.switch.commit()

        # debug
        # self.switch.show_configuration()

        # Configure capture for test (3 TX, 1 RX)
        self.captures[0].select_port('tx')
        self.captures[1].select_port('tx')
        self.captures[2].select_port('tx')
        self.captures[3].select_port('rx')

    def _prepare_frames_with_rate(self, send_port, recv_port, tc, rate_mhz, header_size=None, no_magic=False):
        """Prepare frames for constant input rate.
        """
        dst_mac, _ = get_default_mac(self.crafter, recv_port)
        src_mac, _ = get_default_mac(self.crafter, send_port)
        dst_ip, _ = get_default_ip(self.crafter, tc, recv_port)
        src_ip, _ = get_default_ip(self.crafter, tc, send_port)
        if hasattr(self, 'dst_l4_port'):
            dst_l4_port = self.dst_l4_port
        else:
            dst_l4_port = 5201
        if hasattr(self, 'src_l4_port'):
            src_l4_port = self.src_l4_port
        else:
            src_l4_port = 0xc000

        vlan_param = self.vlan_pcp[tc]
        eol_frame = tsn_efcc.Frame.eol()
        if rate_mhz == 0:
            # eol only
            self.crafter.set_frame(send_port, 0, eol_frame)
            self._show_whole_test_sequence(send_port)
            return 0, 0

        if header_size is None:
            if vlan_param[0] is None:
                # eth(14) + ip(20) + udp(8)
                header_size = 42
            else:
                # eth(14) + vlan(4) + ip(20) + udp(8)
                header_size = 46

        print(f'TC{tc}: rate = {rate_mhz} Mbps')
        l7_payload = 1500 - 28 # ip(20) + udp(8)

        # A: convert the payload length to L1 length to calculate the number of cycles required to transmit one frame.
        l2_length = header_size + l7_payload
        l1_length = l2_length + FRAME_INTERVAL
        min_cycle = l1_length / BYTES_PER_CYCLE

        # B: calculate the number of cycles that can be achieved when transmitting at the target rate.
        target_cycle = min_cycle * MAX_RATE_MHZ / rate_mhz

        # C: calculate the required payload size for the nop frame from (B - A).
        extra_cycle = int(target_cycle - min_cycle)
        nop_length = int(extra_cycle * BYTES_PER_CYCLE)
        nop_payload = nop_length - header_size - FRAME_INTERVAL
        # print(f'l7_payload = {l7_payload}')
        # print(f'l2_length = {l2_length}')
        # print(f'l1_length = {l1_length}')
        # print(f'min_cycle = {min_cycle}')
        # print(f'target_cycle = {target_cycle}')
        # print(f'extra_cycle = {extra_cycle}')
        # print(f'nop_length = {nop_length}')
        # print(f'nop_payload = {nop_payload}')

        max_nop_length = MAX_NOP_PAYLOAD + header_size + FRAME_INTERVAL

        frame = tsn_efcc.Frame().ether(dst_mac, src_mac).vlan(*vlan_param).ipv4(dst_ip, src_ip).udp(dst_l4_port, src_l4_port).payload(l7_payload)

        if no_magic:
            frame.no_magic()

        self.crafter.set_frame(send_port, 0, frame)

        if nop_length > max_nop_length:
            index = 1
            frame2 = frame.clone().payload(MAX_NOP_PAYLOAD).nop()
            while nop_length > max_nop_length:
                self.crafter.set_frame(send_port, index, frame2)
                nop_length -= max_nop_length
                index += 1

            # append payload to last frame
            remain = nop_length
            frame2.payload(remain)
            self.crafter.set_frame(send_port, index - 1, frame2)
            self.crafter.set_frame(send_port, index, eol_frame)
        elif nop_length < 0:
            # send frame without additional interval
            self.crafter.set_frame(send_port, 0, frame)
            self.crafter.set_frame(send_port, 1, eol_frame)
        elif nop_payload < 0:
            # Since nop frame length become minus, use additonal wait instead.
            frame.additional_wait(nop_length)
            self.crafter.set_frame(send_port, 0, frame)
            self.crafter.set_frame(send_port, 1, eol_frame)
        else:
            frame2 = frame.clone().payload(nop_payload).nop()
            self.crafter.set_frame(send_port, 1, frame2)
            self.crafter.set_frame(send_port, 2, eol_frame)

        self._show_whole_test_sequence(send_port)

        # L7 length and L2 length
        return frame.get_length()[::-1]

    def _prepare_burst_frames_with_rate(self, send_port, recv_port, tc, rate_mhz, header_size=None):
        dst_mac, _ = get_default_mac(self.crafter, recv_port)
        src_mac, _ = get_default_mac(self.crafter, send_port)
        dst_ip, _ = get_default_ip(self.crafter, tc, recv_port)
        src_ip, _ = get_default_ip(self.crafter, tc, send_port)

        vlan_param = self.vlan_pcp[tc]
        if header_size is None:
            if vlan_param[0] is None:
                # eth(14) + ip(20) + udp(8)
                header_size = 42
            else:
                # eth(14) + vlan(4) + ip(20) + udp(8)
                header_size = 46

        l7_payload = 1500 - 28 # ip(20) + udp(8)

        # A: convert the payload length to L1 length to calculate the number of cycles required to transmit one frame.
        l2_length = header_size + l7_payload
        l1_length = l2_length + FRAME_INTERVAL
        min_cycle = l1_length / BYTES_PER_CYCLE

        # B: calculate the number of cycles that can be achieved when transmitting at the target rate.
        target_cycle = l1_length * MAX_RATE_MHZ / rate_mhz

        # C: calculate the required payload size for the nop frame from (B - A).
        extra_cycle = int(target_cycle - min_cycle)
        nop_length = int(extra_cycle * BYTES_PER_CYCLE)
        nop_payload = nop_length - header_size - FRAME_INTERVAL

        eol_frame = tsn_efcc.Frame.eol()
        if rate_mhz == 0:
            # eol only
            self.crafter.set_frame(send_port, 0, eol_frame)
            self._show_whole_test_sequence(send_port)
            return 0, 0
        elif rate_mhz == MAX_RATE_MHZ:
            # send maximum size frame
            frame = tsn_efcc.Frame().ether(dst_mac, src_mac).vlan(*vlan_param).ipv4(dst_ip, src_ip).udp(5001, 0xc000).payload(l7_payload)
            self.crafter.set_frame(send_port, 0, frame)
            self.crafter.set_frame(send_port, 1, eol_frame)
            self._show_whole_test_sequence(send_port)
            return frame.get_length()[::-1]
        elif nop_length < 0:
            # send frame without additional interval
            frame = tsn_efcc.Frame().ether(dst_mac, src_mac).vlan(*vlan_param).ipv4(dst_ip, src_ip).udp(5001, 0xc000).payload(l7_payload)
            self.crafter.set_frame(send_port, 0, frame)
            self.crafter.set_frame(send_port, 1, eol_frame)
            self._show_whole_test_sequence(send_port)
            return frame.get_length()[::-1]

        if nop_payload >= MAX_NOP_PAYLOAD + 1:
            raise ValueError(f'Too low rate value. Please consider to increase rate variable')

        # calculate the number of regular frames and nop frames
        max_nop_length = MAX_NOP_PAYLOAD + header_size + FRAME_INTERVAL
        NUM_FRAMES = 1000
        num_regular = 500
        num_nop = NUM_FRAMES - num_regular

        max_regular = 1000
        while True:
            # calculate the maximum burst length.
            new_regular = int((max_regular + num_regular) / 2)
            num_nop = NUM_FRAMES - new_regular
            # print(f'num_regular: {num_regular}, max_regular: {max_regular}, new_regular: {new_regular}')

            regular_length = num_regular * l1_length
            interval_length = num_nop * max_nop_length

            cur_rate = regular_length / (regular_length + interval_length) * MAX_RATE_MHZ
            if cur_rate < rate_mhz:
                num_regular = new_regular
            else:
                max_regular = new_regular

            if max_regular - num_regular <= 1:
                # For safety
                num_regular -= 1
                break

        # found the maximum burst length.
        # Next, calculate the nop length.
        total_l1_length = l1_length * num_regular
        total_nop_length = int(total_l1_length / rate_mhz * (MAX_RATE_MHZ - rate_mhz))
        # print(f'total_l1_length: {total_l1_length}, total_nop_length: {total_nop_length}')

        num_nops = int((total_nop_length + max_nop_length - 1) / max_nop_length)
        nop_size = MAX_NOP_PAYLOAD
        last_nop_size = (total_nop_length % max_nop_length) - header_size - FRAME_INTERVAL

        # print(f'max_nop_length: {max_nop_length}')
        # print(f'num_regular: {num_regular}, num_nops: {num_nops}, last_nop_size: {last_nop_size}')

        last_additional_wait = 0
        if last_nop_size < 0:
            num_nops -= 1
            last_additional_wait = last_nop_size
            last_nop_size = nop_size

        # Construct frame.
        frame = tsn_efcc.Frame().ether(dst_mac, src_mac).vlan(*vlan_param).ipv4(dst_ip, src_ip).udp(5001, 0xc000).payload(l7_payload)
        nop = frame.clone().nop().payload(nop_size)
        last_nop = nop.clone().payload(last_nop_size - FRAME_INTERVAL).additional_wait(last_additional_wait)

        for i in range(num_regular):
            self.crafter.set_frame(send_port, i, frame)

        for i in range(num_nops):
            if i == num_nops - 1:
                self.crafter.set_frame(send_port, i + num_regular, last_nop)
            else:
                self.crafter.set_frame(send_port, i + num_regular, nop)

        if self.args.show_test_sequence:
            print(f'==== Test sequence port {send_port} ====')
            print(f'{frame} x {num_regular}')
            print(f'{nop} x {num_nops - 1}')
            print(f'{last_nop} x {1}')
            print(eol_frame)

        # L7 length and L2 length
        return frame.get_length()[::-1]

    def _show_whole_test_sequence(self, port):
        if self.args.show_test_sequence:
            frames = self.crafter.get_frames(port)
            print(f'==== Test sequence port {port} ====')
            for frame in frames:
                print(frame)


    def _do_transfer(self, crafter_ports, capture_ports, num_frames):
        """Do transfer and returns timestamps for each capture ports (dict of (port, stat)).
        """
        crafter_mask = 0
        for port in crafter_ports:
            crafter_mask |= (1 << port)

        # reset crafter
        self.crafter.reset(0xf)

        # Since crafter has a potential bug that sends a frame after resetting on frame transfer,
        # we start crafter with single eol frame, and reset.
        backup_frames = []
        for port in crafter_ports:
            backup_frames.append(self.crafter.get_frame(port, 0))
            self.crafter.set_frame(port, 0, tsn_efcc.Frame.eol())
        self.crafter.start(crafter_mask)
        self.crafter.reset(0xf)
        for rport in capture_ports:
            self.captures[rport].reset(reset_framecounter=True)

        for port, backup in zip(crafter_ports, backup_frames):
            self.crafter.set_frame(port, 0, backup)

        # Run crafter on repeating mode
        self.crafter.set_repeat(crafter_mask)
        self.crafter.start(crafter_mask)

        # wait until recording is done.
        for rport in capture_ports:
            self.captures[rport].wait(num_frames)

        # stop transfer
        self.crafter.reset(0xf)

        # get results
        results = {}
        for rport in capture_ports:
            stat = self.captures[rport].read_timestamp(num_frames)
            results[rport] = stat

        return results

    def _report_latency(self, results, sender_ports, recv_port, result_dir):
        os.makedirs(result_dir, exist_ok=True)

        rstat = results[recv_port]
        rstat.save_to_csv(f'{result_dir}/recv.csv')
        for sport in sender_ports:
            sstat = self._apply_sender_offset(results[sport])
            sstat.save_to_csv(f'{result_dir}/send{sport}.csv')

            diff = rstat.subtract(sstat)
            diff.save_to_csv(f'{result_dir}/diff_port{sport}.csv')

            freq = self.args.device_frequency

            with open(f'{result_dir}/diff_port{sport}_summary.txt', 'w') as f:
                diff.summary(freq, f=f)


    def _report_bandwidth(self, results, sender_ports, recv_port, frame_size_func, result_dir, filter_max_tid_by_rstat = False):
        os.makedirs(result_dir, exist_ok=True)

        sender_stats = {}
        rstat = results[recv_port]
        rstats_for_port = []
        for sport in sender_ports:
            sstat = self._apply_sender_offset(results[sport])
            sender_stats[sport] = sstat
            freq = self.args.device_frequency

            # filter rstat which is sent from the sender port (sport)
            intersect = rstat.get_intersection(sstat)
            rstats_for_port.append(intersect)

        # get duration from
        start_timestamp = min([min(results[sport].get_timestamps(), default=0xffffffff) for sport in sender_ports])
        end_timestamp = min([max(v.get_timestamps(), default=0xffffffff) for v in results.values()])
        freq = self.args.device_frequency
        duration_sec = (end_timestamp - start_timestamp) / (freq * 1000 * 1000)

        rstat = results[recv_port]
        for sport, rstat_for_port in zip(sender_ports, rstats_for_port):
            sstat = sender_stats[sport]
            if filter_max_tid_by_rstat:
                sstat = sstat.subgroup_by_timestamp(start_timestamp, end_timestamp + 1)
                rstat_for_port = rstat_for_port.subgroup_by_timestamp(start_timestamp, end_timestamp + 1)

            with open(f'{result_dir}/port{sport}_summary_bandwidth.txt', 'w') as f:
                tsn_efcc.TimestampStatistic.summary_bandwidth(sstat, rstat_for_port, freq, frame_size_func, duration_sec=duration_sec, f=f)


    def _apply_sender_offset(self, sender_stat):
        return sender_stat.add_constant(self.args.efcc_latency_offset)
