# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

from tsn_efcc import EFCrafter

def get_default_mac(crafter: EFCrafter, port: int):
    """Read EFCrafter's default table.
    - TABLE[0x1]: for port0
    - TABLE[0x2]: for port1
    - TABLE[0x3]: for port2
    - TABLE[0x4]: for port3
    - TABLE[0x5]: for broadcast (ff:ff:ff:ff:ff:ff)
    :return: tuple of table index and MAC string.
    :rtype: (int, str)
    """
    if port < 4:
        table_index = port + 1
    else:
        # otherwise, return broadcast
        table_index = 5

    return table_index, crafter.get_mac_address(0, table_index)


def get_default_ip(crafter: EFCrafter, tc: int, port: int):
    """Read EFCrafter's default table.
    - TABLE[0x0-0x4]: for 1st network (192.168.0.0/24)
    - TABLE[0x5-0x9]: for 2nd network (10.0.0.0/24)
    - TABLE[0xa-0xe]: for 3rd network (172.16.0.0/24)
    :return: tuple of table index and IP string.
    :rtype: (int, str)
    """
    if tc <= 5:
        tc_offset = 1
    else:
        tc_offset = 5 * (tc - 6) + 1
    table_index = tc_offset + port

    return table_index, crafter.get_ip_address(0, table_index)
