# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import ipaddress
import pyxsdb
from typing import Union, Tuple
from .device_property import AtsSwitchAddressTable, ats_switch_address_table_1g, ats_switch_address_table_1g_zedboard, ats_switch_address_table_10g


# default priority value
DEFAULT_PRIO = 8


class AtsSwitch:
    """A class to control ATS-Switch registers.
    """
    def __init__(self, xsdb: pyxsdb.PyXsdb, xsdb_target: int, design: str):
        """initialize AtsSwitch.

        Args:
            xsdb (pyxsdb.PyXsdb): PyXsdb object (connect() method must be called before)
            xsdb_target (int): The AXI JTAG target of ATS Switch.
            design (str): Design name. Available designs: ['kc705', 'zedboard', 'u45n']
        """
        self._xsdb = xsdb
        self._xsdb_target = xsdb_target

        avail_designs = {
            'kc705': ats_switch_address_table_1g(),
            'zedboard': ats_switch_address_table_1g_zedboard(),
            'u45n': ats_switch_address_table_10g()
        }

        if design not in avail_designs:
            raise ValueError(f'Unknown design name {design}. Available designs: {list(avail_designs.keys())}')

        self._addrtab = avail_designs[design]

    def set_traffic_class(self, priority: int, traffic_class: int, port: int = -1) -> None:
        """Set mapping rules that maps priority (PCP) to traffic class (TC).

        Args:
            priority (int): PCP value (0-7) or non-PCP (DEFAULT_PRIO)
            traffic_class (int): TC value (0-7)
            port (int): input port number. If set to -1, set the mapping rule to the all ports.

        Returns:
            None: none

        Raises:
            ValueError: If error port value is set.
        """
        num_ports = len(self._addrtab.priority_mapppers)
        if port == -1:
            for i in range(num_ports):
                self._set_traffic_class(priority, traffic_class, i)
        elif port < num_ports:
            self._set_traffic_class(priority, traffic_class, port)
        else:
            raise ValueError(f'port must be -1 or less than number of ports ({num_ports}), but got {port}')

    def get_traffic_class(self, priority: int, port: int = 0) -> int:
        """Set assigned traffic class (TC) for input priority (PCP).

        Args:
            priority (int): PCP value (0-7) or non-PCP (DEFAULT_PRIO)
            port (int): input port number.

        Returns:
            int: returns traffic class

        Raises:
            ValueError: If error port value is set.
        """

        pmapper = self._addrtab.priority_mapppers[port]
        prio_offset = priority * 4

        self._set_xsdb_target()
        return self._xsdb.mrd(pmapper + prio_offset)

    def add_flow_rule(self,
                      port: int,
                      tc: int,
                      flow: int,
                      src_ip: Union[str, None] = None,
                      src_port: Union[int, None] = None,
                      dst_ip: Union[str, None] = None,
                      dst_port: Union[int, None] = None) -> None:
        """Set a flow rule that maps tuple(src_ip, src_port, dst_ip, dst_port) to flow.

        Args:
            port (int): switch RX port (0-3)
            tc (int): target traffic class (6 or 7)
            flow (int): flow ID (1-15)
            src_ip (str or None): source IP (string format, xxx.yyy.zzz.www). If set to None, set to wildcard (match any IPs). (default: None)
            src_port (int or None): source UDP port. If set to None, set to wildcard (match any ports). (default: None)
            dst_ip (str or None): destination IP (string format, xxx.yyy.zzz.www). If set to None, set to wildcard (match any IPs). (default: None)
            dst_ip (int or None): destination UDP port. If set to None, set to wildcard (match any ports). (default: None)

        Returns:
            None: none
        """
        self._check_tc(tc)
        self._check_flow(flow)

        if flow == 0:
            raise ValueError('Flow 0 is reserved. Please use from Flow 1 to Flow 15 instead.')

        src_ip_val = self._ip_as_uint(src_ip)
        src_port_val = self._port_as_uint(src_port)
        dst_ip_val = self._ip_as_uint(dst_ip)
        dst_port_val = self._port_as_uint(dst_port)

        tab_index = port * 2 + tc - 6
        flow_base_addrs = self._addrtab.detect_flows[tab_index]
        for flow_base_addr in flow_base_addrs:
            flow_addr = flow_base_addr + (flow - 1) * 0x10

            self._set_xsdb_target()
            self._xsdb.mwr(flow_addr + 0x0, src_ip_val)
            self._xsdb.mwr(flow_addr + 0x4, src_port_val)
            self._xsdb.mwr(flow_addr + 0x8, dst_ip_val)
            self._xsdb.mwr(flow_addr + 0xc, dst_port_val)

    def clear_flow_rule(self,
                        port: int,
                        tc: int,
                        flow: int) -> None:
        """Clear a flow rule.

        Args:
            port (int): switch RX port (0-3)
            tc (int): target traffic class (6 or 7)
            flow (int): flow ID (1-15)

        Returns:
            None: none
        """
        """Clear a flow rule.
        :param int port: switch RX port (0-3)
        :param int tc: target traffic class (6 or 7)
        :param int flow: flow ID (0-15)
        """
        self._check_tc(tc)
        self._check_flow(flow)

        if flow == 0:
            raise ValueError('Flow 0 is reserved. Please use from Flow 1 to Flow 15 instead.')

        tab_index = port * 2 + tc - 6
        flow_base_addrs = self._addrtab.detect_flows[tab_index]
        for flow_base_addr in flow_base_addrs:
            flow_addr = flow_base_addr + (flow - 1) * 0x10

            self._set_xsdb_target()
            self._xsdb.mwr(flow_addr + 0x0, 0xffff_ffff)
            self._xsdb.mwr(flow_addr + 0x4, 0xffff)
            self._xsdb.mwr(flow_addr + 0x8, 0xffff_ffff)
            self._xsdb.mwr(flow_addr + 0xc, 0xffff)

    def get_flow_rule(self,
                      port: int,
                      tc: int,
                      flow: int) -> Tuple[Union[str, None], Union[int, None], Union[str, None], Union[int, None]]:
        """Get a flow rule that maps tuple(src_ip, src_port, dst_ip, dst_port) to flow.

        Args:
            port (int): switch RX port (0-3)
            tc (int): target traffic class (6 or 7)
            flow (int): flow ID (1-15)

        Returns:
            Tuple[Union[str, None], Union[int, None], Union[str, None], Union[int, None]]: returns (src_ip, src_port, dst_ip, dst_port). If a field is None, it means wildcard
        """
        self._check_tc(tc)
        self._check_flow(flow)

        if flow == 0:
            raise ValueError('Flow 0 is reserved. Please use from Flow 1 to Flow 15 instead.')

        tab_index = port * 2 + tc - 6
        flow_base_addrs = self._addrtab.detect_flows[tab_index]
        flow_addr = flow_base_addrs[0] + (flow - 1) * 0x10

        self._set_xsdb_target()
        src_ip = self._xsdb.mrd(flow_addr + 0x0)
        src_port = self._xsdb.mrd(flow_addr + 0x4)
        dst_ip = self._xsdb.mrd(flow_addr + 0x8)
        dst_port = self._xsdb.mrd(flow_addr + 0xc)

        src_ip = self._ip_as_str(src_ip)
        src_port = self._port_as_uint_rev(src_port)
        dst_ip = self._ip_as_str(dst_ip)
        dst_port = self._port_as_uint_rev(dst_port)

        return src_ip, src_port, dst_ip, dst_port

    def set_ats_param(self, port: int, tc: int, flow: int, committed_information_rate: int, committed_burst_size: int):
        """Set ATS parameter (CIR, CBS).

        Args:
            port (int): switch RX port (0-3)
            tc (int): target traffic class (6 or 7)
            flow (int): flow ID (0-15)
            committed_information_rate (int): Committed information rate (Mbps).
            committed_burst_size (int): Committed burst size (bytes).

        Returns:
            None: none
        """
        self._check_tc(tc)
        self._check_flow(flow)

        # Compute recip(CommittedInformationRate) [ps/byte]
        # cir_inv[ps/byte] = 8 [bits/byte] * 1000000 [ps/us] / CIR [Mbps = bits / us]
        cir_inv_ps = int(8000000.0 / committed_information_rate)

        tab_index = port * 2 + tc - 6
        proc_base_addrs = self._addrtab.process_frames[tab_index]
        for proc_base_addr in proc_base_addrs:
            proc_addr = proc_base_addr + 0x8 * flow

            self._set_xsdb_target()
            self._xsdb.mwr(proc_addr + 0x0, cir_inv_ps)
            self._xsdb.mwr(proc_addr + 0x4, committed_burst_size)

    def get_ats_param(self, port: int, tc: int, flow: int) -> Tuple[int, int]:
        """Get ATS parameter (CIR, CBS).

        Args:
            port (int): switch RX port (0-3)
            tc (int): target traffic class (6 or 7)
            flow (int): flow ID (0-15)

        Returns:
            Tuple[int, int]: returns tuple of committed information rate (Mbps) and committed burst size (bytes)
        """
        self._check_tc(tc)
        self._check_flow(flow)

        tab_index = port * 2 + tc - 6
        proc_base_addrs = self._addrtab.process_frames[tab_index]
        proc_base_addr = proc_base_addrs[0]
        proc_addr = proc_base_addr + 0x8 * flow

        self._set_xsdb_target()
        cir_inv_ps = self._xsdb.mrd(proc_addr + 0x0)   # ps/byte
        committed_burst_size = self._xsdb.mrd(proc_addr + 0x4)

        # Compute ComittedInformationRate [Mbps]
        # cir[Mbps] = 8 [bits/byte] * 1000000 [ps/us] / cir_inv [ps/byte]
        try:
            cir = round(8000000.0 / cir_inv_ps)
        except ZeroDivisionError:
            cir = "Inf"

        return cir, committed_burst_size

    def set_max_residence_time(self, port: int, tc: int, max_residence_time: int):
        """Set max residence time.

        Args:
            port (int): switch RX port (0-3)
            tc (int): target traffic class (6 or 7)
            max_residence_time (int): Max residence time (ps).

        Returns:
            None: none
        """
        self._check_tc(tc)

        val1 = max_residence_time & 0xffff_ffff;          # 31: 0
        val2 = (max_residence_time >> 32) & 0xffff_ffff;  # 63:32
        val3 = (max_residence_time >> 64) & 0x0000_00ff;  # 71:64

        tab_index = port * 2 + tc - 6
        proc_base_addrs = self._addrtab.process_frames[tab_index]
        for proc_base_addr in proc_base_addrs:
            proc_addr = proc_base_addr

            self._set_xsdb_target()
            self._xsdb.mwr(proc_addr + 0x80, val1)
            self._xsdb.mwr(proc_addr + 0x84, val2)
            self._xsdb.mwr(proc_addr + 0x88, val3)

    def get_max_residence_time(self, port: int, tc: int) -> int:
        """Get max residence time.

        Args:
            port (int): switch RX port (0-3)
            tc (int): target traffic class (6 or 7)

        Returns:
            int: returns Max residence time (ps).
        """
        self._check_tc(tc)

        tab_index = port * 2 + tc - 6
        proc_base_addrs = self._addrtab.process_frames[tab_index]
        proc_base_addr = proc_base_addrs[0]
        proc_addr = proc_base_addr

        self._set_xsdb_target()
        val1 = self._xsdb.mrd(proc_addr + 0x80)
        val2 = self._xsdb.mrd(proc_addr + 0x84)
        val3 = self._xsdb.mrd(proc_addr + 0x88)

        val = val1
        val = val | (val2 << 32)
        val = val | (val3 << 64)

        return val

    def set_processing_delay_max(self, processing_delay_max):
        """Set Processing Delay Max (PDM).

        PDM is used to denote system's internal delay value.
        The The timestamp id is adjusted by PDM value on deadline computation.

        Args:
            processing_delay_max (int): PDM value (ps).

        Returns:
            None: none
        """
        val1 = processing_delay_max & 0xffff_ffff;          # 31: 0
        val2 = (processing_delay_max >> 32) & 0xffff_ffff;  # 63:32
        val3 = (processing_delay_max >> 64) & 0x0000_00ff;  # 71:64

        self._set_xsdb_target()
        self._xsdb.mwr(self._addrtab.processing_delay_max + 0, val1)
        self._xsdb.mwr(self._addrtab.processing_delay_max + 4, val2)
        self._xsdb.mwr(self._addrtab.processing_delay_max + 8, val3)

    def get_processing_delay_max(self) -> int:
        """Get Processing Delay Max (PDM).

        PDM is used to denote system's internal delay value.
        The The timestamp id is adjusted by PDM value on deadline computation.

        Args:
            None

        Returns:
            int: returns PDM value (ps).
        """
        self._set_xsdb_target()
        val1 = self._xsdb.mrd(self._addrtab.processing_delay_max + 0)
        val2 = self._xsdb.mrd(self._addrtab.processing_delay_max + 4)
        val3 = self._xsdb.mrd(self._addrtab.processing_delay_max + 8)

        val = val1
        val = val | (val2 << 32)
        val = val | (val3 << 64)

        return val

    def get_commit_hash(self) -> int:
        """Get commit hash used to implement the current bitstream

        Args:
            None: none

        Returns:
            int: 8-digit Git commit hash
        """
        hash = self._addrtab.commit_hash
        if hash is None:
            raise ValueError('This board does not support reading commit hash')
        self._set_xsdb_target()
        return hex(self._xsdb.mrd(hash))

    def _ip_as_uint(self, ip):
        if ip is None:
            return 0
        elif isinstance(ip, str):
            return int(ipaddress.ip_address(ip))
        else:
            raise ValueError(f'Unknown IP type: type={type(ip)}, value={ip}')

    def _port_as_uint(self, port):
        if port is None:
            return 0
        elif isinstance(port, int):
            return port
        else:
            raise ValueError(f'Unknown port type: type={type(port)}, value={port}')

    def _ip_as_str(self, ip):
        if ip == 0:
            return None
        return str(ipaddress.ip_address(ip))

    def _port_as_uint_rev(self, port):
        if port == 0:
            return None
        return port

    def _set_traffic_class(self, priority: int, traffic_class: int, port: int) -> None:
        pmapper = self._addrtab.priority_mapppers[port]
        prio_offset = priority * 4

        self._set_xsdb_target()
        self._xsdb.mwr(pmapper + prio_offset, traffic_class)

    def _set_slope(self, tc: int, idle_slope: int, send_slope: int,
                   hi_credit: int, lo_credit: int, port: int) -> None:
        if tc == 6:
            pslope = self._addrtab.ats_tc6[port]
        elif tc == 7:
            pslope = self._addrtab.ats_tc7[port]
        else:
            raise ValueError(f'set_slope supports only TC6 or TC7, but got tc={tc}')

        self._set_xsdb_target()
        self._xsdb.mwr(pslope + 0, idle_slope)
        self._xsdb.mwr(pslope + 8, send_slope)
        self._xsdb.mwr(pslope + 0x10000, hi_credit)
        self._xsdb.mwr(pslope + 0x10008, lo_credit)

    def _check_tc(self, tc, minval=6, maxval=7):
        if tc < minval or tc > maxval:
            raise ValueError(f'TC value ({tc}) is not in range {minval} <= TC <= {maxval}. ')

    def _check_flow(self, flow, minval=0, maxval=15):
        if flow < minval or flow > maxval:
            raise ValueError(f'Flow value ({flow}) is not in range {minval} <= Flow <= {maxval}. ')

    def _set_xsdb_target(self):
        self._xsdb.target(self._xsdb_target)


if __name__ == '__main__':
    xsdb = pyxsdb.PyXsdb()
    xsdb.connect()

    xsdb_target = 9
    ats = AtsSwitch(xsdb, xsdb_target, 'kc705')

    # default -> TC5, PCP2 -> TC6, PCP3 -> TC7
    ats.set_traffic_class(DEFAULT_PRIO, 5)
    ats.set_traffic_class(2, 6)
    ats.set_traffic_class(3, 7)

    # set flow (10.0.0.1:* -> 10.0.0.2:5201) -> flow id 0
    # committed information rate = 100 Mbps, committed burst size = 1542 Bytes
    ats.add_flow_rule(port=0, tc=6, flow=1, src_ip="10.0.0.1", src_port=None, dst_ip="10.0.0.2", dst_port=5201)
    ats.set_ats_param(port=0, tc=6, flow=1, committed_information_rate=100, committed_burst_size=1542)
    ats.clear_flow_rule(port=0, tc=6, flow=1)

    ats.set_processing_delay_max(5000000)
    ats.set_max_residence_time(port=0, tc=6, max_residence_time=100000000)
