# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import dataclasses
from ctypes import c_int32
import pyxsdb
from typing import Union, List, Tuple

@dataclasses.dataclass
class CbsSwitchAddressTable():
    """Address map of CBS Switch.
    """
    cbs_tc6: Tuple[int] = (
        0x4000_0000,
        0x4004_0000,
        0x4008_0000,
        0x400c_0000)
    cbs_tc7: Tuple[int] = (
        0x4002_0000,
        0x4006_0000,
        0x400a_0000,
        0x400e_0000)
    pause_ctrl: int = 0x40100000
    priority_mapppers: Tuple[int] = (
        0x5000_0000,
        0x5001_0000,
        0x5002_0000,
        0x5003_0000)
    pulse_generator = None
    commit_hash: int = 0x00100000

def default_cbs_switch_address_table() -> CbsSwitchAddressTable:
    """Returns a default address table of CBS Switch.

    Returns:
        CbsSwitchAddressTable: default address table.
    """
    return CbsSwitchAddressTable()

def default_cbs_switch_address_table_zedboard() -> CbsSwitchAddressTable:
    """Returns a default address table of CBS Switch.

    Returns:
        CbsSwitchAddressTable: default address table.
    """
    tab = CbsSwitchAddressTable()
    tab.commit_hash = None
    return tab

def cbs_switch_address_table_zedboard_with_probes() -> CbsSwitchAddressTable:
    """Returns a default address table of CBS Switch.

    Returns:
        CbsSwitchAddressTable: default address table.
    """
    tab = CbsSwitchAddressTable()
    tab.pulse_generator = 0x40110000
    tab.commit_hash = None
    return tab

def default_cbs_switch_address_table_10g() -> CbsSwitchAddressTable:
    """Returns a default address table of CBS Switch.

    Returns:
        CbsSwitchAddressTable: default address table for 10G.
    """
    address_table_10g = CbsSwitchAddressTable()

    address_table_10g.cbs_tc6 = (
        0x4000_0000,
        0x4004_0000,
        0x4008_0000,
        0x400c_0000,
        0x4010_0000,
        0x4014_0000,
        0x4018_0000,
        0x401c_0000)

    address_table_10g.cbs_tc7 = (
        0x4002_0000,
        0x4006_0000,
        0x400a_0000,
        0x400e_0000,
        0x4012_0000,
        0x4016_0000,
        0x401a_0000,
        0x401e_0000)

    address_table_10g.pause_ctrl = None

    address_table_10g.priority_mapppers = (
        0x5000_0000,
        0x5001_0000,
        0x5002_0000,
        0x5003_0000,
        0x5004_0000,
        0x5005_0000,
        0x5006_0000,
        0x5007_0000)

    return address_table_10g


# default priority value
DEFAULT_PRIO = 8

class CbsSwitch:
    """A class to control CBS-Switch registers.
    """
    def __init__(self, xsdb: pyxsdb.PyXsdb, xsdb_target: int, design: str):
        """initialize CbsSwitch.

        Args:
            xsdb (pyxsdb.PyXsdb): PyXsdb object (connect() method must be called before)
            xsdb_target (int): The AXI JTAG target of CBS Switch.
            design (str): Design name. Available designs: ['kc705', 'zedboard', 'zedboard_with_probes', 'u45n']
        """
        self._xsdb = xsdb
        self._xsdb_target = xsdb_target

        avail_designs = {
            'kc705': default_cbs_switch_address_table(),
            'zedboard': default_cbs_switch_address_table_zedboard(),
            'zedboard_with_probes': cbs_switch_address_table_zedboard_with_probes(),
            'u45n': default_cbs_switch_address_table_10g()
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

    def set_slope(self, tc: int, idle_slope: int, send_slope: int,
                  hi_credit: int = 0x7fff_ffff,
                  lo_credit: int = 0x8000_0000,
                  port: int = -1) -> None:
        """Set CBS's shaper rule.

        Args:
            tc (int): TC (traffic class) value (0-7)
            idle_slope (int): idle slope value (unit: kbps)
            send_slope (int): send slope value (unit: kbps)
            hi_credit (int): upper bound of slope (default: 0x7fff_ffff (int32))
            lo_credit (int): lower bound of slope (default: 0x8000_0000 (int32))
            port (int): input port number. If set to -1, set the mapping rule to the all ports.

        Returns:
            None: none

        Raises:
            ValueError: If error port value is set.
        """
        num_ports = len(self._addrtab.cbs_tc6)
        if port == -1:
            for i in range(num_ports):
                self._set_slope(tc, idle_slope, send_slope, hi_credit, lo_credit, i)
        elif port < num_ports:
            self._set_slope(tc, idle_slope, send_slope, hi_credit, lo_credit, port)
        else:
            raise ValueError(f'port must be -1 or less than number of ports ({num_ports}), but got {port}')

    def get_slope(self, tc: int, port: int = 0) -> Tuple[int, int, int, int]:
        """Get CBS's shaper rule.

        Args:
            tc (int): TC (traffic class) value (0-7)
            port (int): input port number

        Returns:
            Tuple[int, int, int, int]: returns (idle_slope, send_slope, hi_credit, lo_credit)

        Raises:
            ValueError: If error port value is set.
        """
        num_ports = len(self._addrtab.cbs_tc6)

        if tc == 6:
            pslope = self._addrtab.cbs_tc6[port]
        elif tc == 7:
            pslope = self._addrtab.cbs_tc7[port]
        else:
            raise ValueError(f'get_slope supports only TC6 or TC7, but got tc={tc}')

        self._set_xsdb_target()
        idle_slope = c_int32(self._xsdb.mrd(pslope + 0)).value
        send_slope = c_int32(self._xsdb.mrd(pslope + 8)).value
        hi_credit = c_int32(self._xsdb.mrd(pslope + 0x10000)).value
        lo_credit = c_int32(self._xsdb.mrd(pslope + 0x10008)).value

        return idle_slope, send_slope, hi_credit, lo_credit

    def set_flow_control(self, flow_control_en=False) -> None:
        """Toggle internal flow control.

        Note:
            Do not use this function if you are not familiar with the flow control within the switch.

        Args:
            flow_control_en (bool): If true, enable TEMAC's internal flow control instead of internal frame dropper. Otherwise, use internal frame dropper.

        Returns:
            None: none
        """
        self._set_xsdb_target()
        pflow = self._addrtab.pause_ctrl

        if flow_control_en:
            self._xsdb.mwr(pflow, 1)
        else:
            self._xsdb.mwr(pflow, 0)

    def get_flow_control(self) -> bool:
        """Get current flow control

        Note:
            Do not use this function if you are not familiar with the flow control within the switch.

        Args:
            None: none

        Returns:
            bool: If true, switch uses TEMAC's internal flow control. Otherwise, switch uses internal frame dropper.
        """
        self._set_xsdb_target()
        pflow = self._addrtab.pause_ctrl

        flow_control_en = self._xsdb.mrd(pflow)
        flow_control_en = True if flow_control_en != 0 else False

        return flow_control_en

    def set_pulse_probes(self, output_pin: int, mask: int) -> None:
        """Enable pulse probe of an output pin.

        Args:
            output_pin (int): output probe bins (0 <= output_pin < 4)
            mask (int): bitmask to select input probe.

        Returns:
            None: none

        Note:
            A Mask bit is corresponded to the following input probe points:
            - mask[ 3: 0] = Probe point #0 for port 0, [3] = TC7, [2] = TC6, [1] = TC5, [0] = TC1
            - mask[ 7: 4] = Probe point #0 for port 1, ...
            - mask[11: 8] = Probe point #0 for port 2, ...
            - mask[15:12] = Probe point #0 for port 3, ...
            - mask[19:16] = Probe point #1 for port 0, [19] = TC7, [18] = TC6, [17] = TC5, [16] = TC1
            - mask[23:20] = Probe point #1 for port 1, ...
            - mask[27:24] = Probe point #1 for port 2, ...
            - mask[31:28] = Probe point #1 for port 3, ...
            - mask[33:32] = Probe point #2 for port 0, [33] = TX, [32] = RX
            - mask[35:34] = Probe point #2 for port 1, ...
            - mask[37:36] = Probe point #2 for port 2, ...
            - mask[39:38] = Probe point #2 for port 3, ...
        """
        mask_lo = mask & 0xffff_ffff
        mask_hi = (mask >> 32) & 0x0000_00ff

        baseaddr = output_pin * 8

        pulse = self._addrtab.pulse_generator
        if pulse is None:
            raise ValueError('This board does not support for pulse generator')

        self._set_xsdb_target()
        self._xsdb.mwr(pulse + baseaddr, mask_lo)
        self._xsdb.mwr(pulse + baseaddr + 4, mask_hi)

    def get_pulse_probes(self, output_pin: int) -> int:
        """Enable pulse probe of an output pin.

        Args:
            output_pin (int): output probe bins (0 <= output_pin < 4)

        Returns:
            int: pulse probe mask for port

        Note:
            A Mask bit is corresponded to the following input probe points:
            - mask[ 3: 0] = Probe point #0 for port 0, [3] = TC7, [2] = TC6, [1] = TC5, [0] = TC1
            - mask[ 7: 4] = Probe point #0 for port 1, ...
            - mask[11: 8] = Probe point #0 for port 2, ...
            - mask[15:12] = Probe point #0 for port 3, ...
            - mask[19:16] = Probe point #1 for port 0, [19] = TC7, [18] = TC6, [17] = TC5, [16] = TC1
            - mask[23:20] = Probe point #1 for port 1, ...
            - mask[27:24] = Probe point #1 for port 2, ...
            - mask[31:28] = Probe point #1 for port 3, ...
            - mask[33:32] = Probe point #2 for port 0, [33] = TX, [32] = RX
            - mask[35:34] = Probe point #2 for port 1, ...
            - mask[37:36] = Probe point #2 for port 2, ...
            - mask[39:38] = Probe point #2 for port 3, ...
        """
        baseaddr = output_pin * 8

        pulse = self._addrtab.pulse_generator
        if pulse is None:
            raise ValueError('This board does not support for pulse generator')

        self._set_xsdb_target()
        mask_lo = self._xsdb.mrd(pulse + baseaddr)
        mask_hi = self._xsdb.mrd(pulse + baseaddr + 4)
        return mask_lo | (mask_hi << 32)

    def set_pulse_width(self, pulse_width: int) -> None:
        """Set pulse width

        Args:
            pulse_width (int): Pulse width. In typical case, this value is the frame length of the expected input.

        Returns:
            None: none
        """
        pulse = self._addrtab.pulse_generator
        if pulse is None:
            raise ValueError('This board does not support for pulse generator')

        self._set_xsdb_target()
        self._xsdb.mwr(pulse + 0x100, pulse_width)

    def get_pulse_width(self) -> int:
        """Get pulse width

        Args:
            None: none

        Returns:
            int: pulse width
        """
        pulse = self._addrtab.pulse_generator
        self._set_xsdb_target()
        return self._xsdb.mrd(pulse + 0x100)

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

    def _set_traffic_class(self, priority: int, traffic_class: int, port: int) -> None:
        pmapper = self._addrtab.priority_mapppers[port]
        prio_offset = priority * 4

        self._set_xsdb_target()
        self._xsdb.mwr(pmapper + prio_offset, traffic_class)

    def _set_slope(self, tc: int, idle_slope: int, send_slope: int,
                   hi_credit: int, lo_credit: int, port: int) -> None:
        if tc == 6:
            pslope = self._addrtab.cbs_tc6[port]
        elif tc == 7:
            pslope = self._addrtab.cbs_tc7[port]
        else:
            raise ValueError(f'set_slope supports only TC6 or TC7, but got tc={tc}')

        self._set_xsdb_target()
        self._xsdb.mwr(pslope + 0, idle_slope)
        self._xsdb.mwr(pslope + 8, send_slope)
        self._xsdb.mwr(pslope + 0x10000, hi_credit)
        self._xsdb.mwr(pslope + 0x10008, lo_credit)

    def _set_xsdb_target(self):
        self._xsdb.target(self._xsdb_target)


if __name__ == '__main__':
    xsdb = pyxsdb.PyXsdb()
    xsdb.connect()

    xsdb_target = 9
    cbs = CbsSwitch(xsdb, xsdb_target, 'zedboard')

    # default -> TC5, PCP2 -> TC6, PCP3 -> TC7
    cbs.set_traffic_class(DEFAULT_PRIO, 5)
    cbs.set_traffic_class(2, 6)
    cbs.set_traffic_class(3, 7)

    # slope (TC6): idle = 100000 Kbps, send = -900000 Kbps
    # slope (TC7): idle =  10000 Kbps, send = -990000 Kbps
    cbs.set_slope(6, 100000, -900000)
    cbs.set_slope(7,  10000, -990000)
