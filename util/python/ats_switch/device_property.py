# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import dataclasses
from typing import Tuple


def _get_default_ats_addrs(in_port, tc, is_odd) -> Tuple[int]:
    # get output port
    out_ports = []
    for i in range(4):
        if i != in_port:
            out_ports.append(i)

    BASE_ADDR = 0x0000_0000
    OUT_PORT_OFFSET = 0x0000_c000
    PRIORITY_OFFSET = 0x6000
    IN_PORT_OFFSET = 0x2000
    ODD_OFFSET = 0x1000

    # for each output port, generate target address
    addrs = []
    for oport in out_ports:
        # the index of input port id is different for each output port
        # in = 0: oport1.ATS_PXX_0, oport2.ATS_PXX_0, oport3.ATX_PXX_0
        # in = 1: oport0.ATS_PXX_0, oport2.ATS_PXX_1, oport3.ATX_PXX_1
        # in = 2: oport0.ATS_PXX_1, oport1.ATS_PXX_1, oport3.ATX_PXX_2
        # in = 3: oport0.ATS_PXX_2, oport1.ATS_PXX_2, oport2.ATX_PXX_2

        if oport < in_port:
            in_port_idx = max(0, in_port - 1)
        elif oport > in_port:
            in_port_idx = min(2, in_port)
        else:
            # This condition is not met
            pass

        addr = BASE_ADDR
        addr += oport * OUT_PORT_OFFSET
        addr += (tc - 6) * PRIORITY_OFFSET
        addr += in_port_idx * IN_PORT_OFFSET
        if is_odd:
            addr += ODD_OFFSET

        if addr >= 0x10000:
            # Since 0x10000 is used by AXI GPIO (flow control), skip this.
            addr += 0x1000

        if addr == 0x30000:
            addr = 0x40000

        if addr == 0x20000:
            addr = 0x30000

        addrs.append(addr)

    return tuple(addrs)


def _get_default_ats_addrs_10g(in_port, tc, is_odd) -> Tuple[int]:
    # get output port
    out_ports = []
    for i in range(8):
        if i != in_port:
            out_ports.append(i)

    BASE_ADDR = 0x0200_0000
    OUT_PORT_OFFSET = 0xe000
    PRIORITY_OFFSET = 0x7000
    IN_PORT_OFFSET = 0x1000
    ODD_OFFSET = 0x0600_0000

    # for each output port, generate target address
    addrs = []
    for oport in out_ports:
        # the index of input port id is different for each output port
        # in = 0: oport1.ATS_PXX_0, oport2.ATS_PXX_0, oport3.ATX_PXX_0, oport4.ATS_PXX_0, oport5.ATX_PXX_0, oport6.ATS_PXX_0, oport7.ATX_PXX_0
        # in = 1: oport0.ATS_PXX_0, oport2.ATS_PXX_1, oport3.ATX_PXX_1, oport4.ATS_PXX_1, oport5.ATX_PXX_1, oport6.ATS_PXX_1, oport7.ATX_PXX_1
        # in = 2: oport0.ATS_PXX_1, oport1.ATS_PXX_1, oport3.ATX_PXX_2, oport4.ATS_PXX_2, oport5.ATX_PXX_2, oport6.ATS_PXX_2, oport7.ATX_PXX_2
        # in = 3: oport0.ATS_PXX_2, oport1.ATS_PXX_2, oport2.ATX_PXX_2, oport4.ATS_PXX_3, oport5.ATX_PXX_3, oport6.ATS_PXX_3, oport7.ATX_PXX_3
        # in = 4: oport0.ATS_PXX_3, oport1.ATS_PXX_3, oport2.ATX_PXX_3, oport3.ATS_PXX_3, oport5.ATX_PXX_4, oport6.ATS_PXX_4, oport7.ATX_PXX_4
        # in = 5: oport0.ATS_PXX_4, oport1.ATS_PXX_4, oport2.ATX_PXX_4, oport3.ATS_PXX_4, oport4.ATX_PXX_4, oport6.ATS_PXX_5, oport7.ATX_PXX_5
        # in = 6: oport0.ATS_PXX_5, oport1.ATS_PXX_5, oport2.ATX_PXX_5, oport3.ATS_PXX_5, oport4.ATX_PXX_5, oport5.ATS_PXX_5, oport7.ATX_PXX_6
        # in = 7: oport0.ATS_PXX_6, oport1.ATS_PXX_6, oport2.ATX_PXX_6, oport3.ATS_PXX_6, oport4.ATX_PXX_6, oport5.ATS_PXX_6, oport6.ATX_PXX_6

        if oport < in_port:
            in_port_idx = max(0, in_port - 1)
        elif oport > in_port:
            in_port_idx = min(2, in_port)
        else:
            # This condition is not met
            pass

        addr = BASE_ADDR
        addr += oport * OUT_PORT_OFFSET
        addr += (tc - 6) * PRIORITY_OFFSET
        addr += in_port_idx * IN_PORT_OFFSET
        if is_odd:
            addr += ODD_OFFSET

        addrs.append(addr)

    return tuple(addrs)


@dataclasses.dataclass
class AtsSwitchAddressTable():
    """Address map of ATS Switch.
    """
    detect_flows: Tuple[Tuple[int]] = (
        _get_default_ats_addrs(in_port=0, tc=6, is_odd=False),
        _get_default_ats_addrs(in_port=0, tc=7, is_odd=False),
        _get_default_ats_addrs(in_port=1, tc=6, is_odd=False),
        _get_default_ats_addrs(in_port=1, tc=7, is_odd=False),
        _get_default_ats_addrs(in_port=2, tc=6, is_odd=False),
        _get_default_ats_addrs(in_port=2, tc=7, is_odd=False),
        _get_default_ats_addrs(in_port=3, tc=6, is_odd=False),
        _get_default_ats_addrs(in_port=3, tc=7, is_odd=False),)
    process_frames: Tuple[Tuple[int]] = (
        _get_default_ats_addrs(in_port=0, tc=6, is_odd=True),
        _get_default_ats_addrs(in_port=0, tc=7, is_odd=True),
        _get_default_ats_addrs(in_port=1, tc=6, is_odd=True),
        _get_default_ats_addrs(in_port=1, tc=7, is_odd=True),
        _get_default_ats_addrs(in_port=2, tc=6, is_odd=True),
        _get_default_ats_addrs(in_port=2, tc=7, is_odd=True),
        _get_default_ats_addrs(in_port=3, tc=6, is_odd=True),
        _get_default_ats_addrs(in_port=3, tc=7, is_odd=True),)
    processing_delay_max: int = 0x0002_0000
    priority_mapppers: Tuple[int] = (
        0x5000_0000,
        0x5001_0000,
        0x5002_0000,
        0x5003_0000,
        0x5004_0000,
        0x5005_0000,
        0x5006_0000,
        0x5007_0000,
        0x5008_0000,
        0x5009_0000,
        0x500a_0000,
        0x500b_0000,
        0x500c_0000,
        0x500d_0000,
        0x500e_0000,
        0x500f_0000)
    commit_hash: int = 0x0002_000c


def default_ats_switch_address_table() -> AtsSwitchAddressTable:
    """Returns a default address table of ATS Switch.

    Returns:
        AtsSwitchAddressTable: default address table.
    """
    return AtsSwitchAddressTable()


def ats_switch_address_table_1g() -> AtsSwitchAddressTable:
    """Returns an address table of 1G ATS Switch design.

    Returns:
        AtsSwitchAddressTable: an address table of 1G ATS Switch design
    """
    return default_ats_switch_address_table()


def ats_switch_address_table_1g_zedboard() -> AtsSwitchAddressTable:
    """Returns an address table of 1G ATS Switch design for ZedBoard.

    Returns:
        AtsSwitchAddressTable: an address table of 1G ATS Switch design for ZedBoard
    """

    # The number of scheduler instances are different.
    tab = AtsSwitchAddressTable()
    tab.detect_flows = (
        (0x0000_0000,),  # port0, TC6
        (0x0000_2000,),  # port0, TC7
        (0x0000_4000,),  # port1, TC6
        (0x0000_6000,),  # ...
        (0x0000_8000,),
        (0x0000_a000,),
        (0x0000_c000,),
        (0x0000_e000,))
    tab.process_frames = (
        (0x0000_1000,),  # port0, TC6
        (0x0000_3000,),  # port0, TC7
        (0x0000_5000,),  # port1, TC6
        (0x0000_7000,),  # ...
        (0x0000_9000,),
        (0x0000_b000,),
        (0x0000_d000,),
        (0x0000_f000,))
    tab.commit_hash = None

    return tab


def ats_switch_address_table_10g() -> AtsSwitchAddressTable:
    """Returns an address table of 10G ATS Switch design.

    Returns:
        AtsSwitchAddressTable: an address table of 10G ATS Switch design
    """

    # The number of scheduler instances are different.
    tab = AtsSwitchAddressTable()
    tab.detect_flows = (
        _get_default_ats_addrs_10g(in_port=0, tc=6, is_odd=False),
        _get_default_ats_addrs_10g(in_port=0, tc=7, is_odd=False),
        _get_default_ats_addrs_10g(in_port=1, tc=6, is_odd=False),
        _get_default_ats_addrs_10g(in_port=1, tc=7, is_odd=False),
        _get_default_ats_addrs_10g(in_port=2, tc=6, is_odd=False),
        _get_default_ats_addrs_10g(in_port=2, tc=7, is_odd=False),
        _get_default_ats_addrs_10g(in_port=3, tc=6, is_odd=False),
        _get_default_ats_addrs_10g(in_port=3, tc=7, is_odd=False),
        _get_default_ats_addrs_10g(in_port=4, tc=6, is_odd=False),
        _get_default_ats_addrs_10g(in_port=4, tc=7, is_odd=False),
        _get_default_ats_addrs_10g(in_port=5, tc=6, is_odd=False),
        _get_default_ats_addrs_10g(in_port=5, tc=7, is_odd=False),
        _get_default_ats_addrs_10g(in_port=6, tc=6, is_odd=False),
        _get_default_ats_addrs_10g(in_port=6, tc=7, is_odd=False),
        _get_default_ats_addrs_10g(in_port=7, tc=6, is_odd=False),
        _get_default_ats_addrs_10g(in_port=7, tc=7, is_odd=False),)
    tab.process_frames = (
        _get_default_ats_addrs_10g(in_port=0, tc=6, is_odd=True),
        _get_default_ats_addrs_10g(in_port=0, tc=7, is_odd=True),
        _get_default_ats_addrs_10g(in_port=1, tc=6, is_odd=True),
        _get_default_ats_addrs_10g(in_port=1, tc=7, is_odd=True),
        _get_default_ats_addrs_10g(in_port=2, tc=6, is_odd=True),
        _get_default_ats_addrs_10g(in_port=2, tc=7, is_odd=True),
        _get_default_ats_addrs_10g(in_port=3, tc=6, is_odd=True),
        _get_default_ats_addrs_10g(in_port=3, tc=7, is_odd=True),
        _get_default_ats_addrs_10g(in_port=4, tc=6, is_odd=True),
        _get_default_ats_addrs_10g(in_port=4, tc=7, is_odd=True),
        _get_default_ats_addrs_10g(in_port=5, tc=6, is_odd=True),
        _get_default_ats_addrs_10g(in_port=5, tc=7, is_odd=True),
        _get_default_ats_addrs_10g(in_port=6, tc=6, is_odd=True),
        _get_default_ats_addrs_10g(in_port=6, tc=7, is_odd=True),
        _get_default_ats_addrs_10g(in_port=7, tc=6, is_odd=True),
        _get_default_ats_addrs_10g(in_port=7, tc=7, is_odd=True),)
    tab.priority_mapppers = (
        0x0400_0000,
        0x0400_1000,
        0x0400_2000,
        0x0400_3000,
        0x0400_4000,
        0x0400_5000,
        0x0400_6000,
        0x0400_7000,
        0x0400_8000,
        0x0400_9000,
        0x0400_a000,
        0x0400_b000,
        0x0400_c000,
        0x0400_d000,
        0x0400_e000,
        0x0400_f000,
        0x0401_0000,
        0x0401_1000,
        0x0401_2000,
        0x0401_3000,
        0x0401_4000,
        0x0401_5000,
        0x0401_6000,
        0x0401_7000,
        0x0401_8000,
        0x0401_9000,
        0x0401_a000,
        0x0401_b000,
        0x0401_c000,
        0x0401_d000,
        0x0401_e000,
        0x0401_f000,
        0x0402_0000,
        0x0402_1000,
        0x0402_2000,
        0x0402_3000,
        0x0402_4000,
        0x0402_5000,
        0x0402_6000,
        0x0402_7000,
        0x0402_8000,
        0x0402_9000,
        0x0402_a000,
        0x0402_b000,
        0x0402_c000,
        0x0402_d000,
        0x0402_e000,
        0x0402_f000,
        0x0403_0000,
        0x0403_1000,
        0x0403_2000,
        0x0403_3000,
        0x0403_4000,
        0x0403_5000,
        0x0403_6000,
        0x0403_7000,
        0x0403_8000,
        0x0403_9000,
        0x0403_a000,
        0x0403_b000,
        0x0403_c000,
        0x0403_d000,
        0x0403_e000,
        0x0403_f000)

    return tab
