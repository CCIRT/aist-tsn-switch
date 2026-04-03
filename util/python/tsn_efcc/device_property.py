# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

from dataclasses import dataclass
from typing import Union, List, Tuple


@dataclass
class TsnEfccAddressTable():
    """Address map of TSN EFCC.
    """
    ef_crafter: int = 0x5f00_0000
    ef_crafter_buffers: Tuple[int] = (
        0x5000_0000,
        0x5100_0000,
        0x5200_0000,
        0x5300_0000)
    ef_crafter_ip_tables: Tuple[int] = (
        0x5400_0000,
        0x5500_0000,
        0x5600_0000,
        0x5700_0000)
    ef_crafter_mac_tables: Tuple[int] = (
        0x5800_0000,
        0x5900_0000,
        0x5a00_0000,
        0x5b00_0000)
    ef_capture_tx_ctrl: Tuple[int] = (
        0x4f00_0000,
        0x4f01_0000,
        0x4f02_0000,
        0x4f03_0000)
    ef_capture_rx_ctrl: Tuple[int] = (
        0x4f04_0000,
        0x4f05_0000,
        0x4f06_0000,
        0x4f07_0000)
    ef_capture_buffers: Tuple[int] = (
        0x4000_0000,
        0x4100_0000,
        0x4200_0000,
        0x4300_0000)
    ef_capture_buffer_switch: Tuple[int] = (
        0x4f10_0000,
        0x4f11_0000,
        0x4f12_0000,
        0x4f13_0000)
    axis_net_switch: int = 0x6000_0000
    commit_hash: int = 0x0010_0000
    efcc_type = '1g'

def default_tsn_efcc_address_table() -> TsnEfccAddressTable:
    """Returns default TsnEfccAddressTable instance.

    Returns:
        TsnEfccAddressTable: default address table.
    """
    return TsnEfccAddressTable()

def default_tsn_efcc_address_table_10g() -> TsnEfccAddressTable:
    """Returns default TsnEfccAddressTable instance.

    Returns:
        TsnEfccAddressTable: default address table 10G.
    """
    address_table_10g = TsnEfccAddressTable()

    address_table_10g.ef_crafter_buffers = (
        0x5000_0000,
        0x5100_0000,
        0x5200_0000,
        0x5300_0000,
        0x5010_0000,
        0x5110_0000,
        0x5210_0000,
        0x5310_0000)
    address_table_10g.ef_crafter_ip_tables = (
        0x5400_0000,
        0x5500_0000,
        0x5600_0000,
        0x5700_0000,
        0x5410_0000,
        0x5510_0000,
        0x5610_0000,
        0x5710_0000)
    address_table_10g.ef_crafter_mac_tables = (
        0x5800_0000,
        0x5900_0000,
        0x5a00_0000,
        0x5b00_0000,
        0x5810_0000,
        0x5910_0000,
        0x5a10_0000,
        0x5b10_0000)
    address_table_10g.ef_capture_tx_ctrl = (
        0x4f00_0000,
        0x4f01_0000,
        0x4f02_0000,
        0x4f03_0000,
        0x4f04_0000,
        0x4f05_0000,
        0x4f06_0000,
        0x4f07_0000)
    address_table_10g.ef_capture_rx_ctrl = (
        0x4f00_8000,
        0x4f01_8000,
        0x4f02_8000,
        0x4f03_8000,
        0x4f04_8000,
        0x4f05_8000,
        0x4f06_8000,
        0x4f07_8000)
    address_table_10g.ef_capture_buffers = (
        # tx
        0x4000_0000,
        0x4100_0000,
        0x4200_0000,
        0x4300_0000,
        0x4400_0000,
        0x4500_0000,
        0x4600_0000,
        0x4700_0000,
        # rx
        0x4080_0000,
        0x4180_0000,
        0x4280_0000,
        0x4380_0000,
        0x4480_0000,
        0x4580_0000,
        0x4680_0000,
        0x4780_0000)
    address_table_10g.axis_net_switch = (
        0x6000_0000,
        0x6000_1000)
    address_table_10g.efcc_type = '10g'

    return address_table_10g


@dataclass
class AxisNetSwitchConfig():
    """A config class of AxisNetSwitch. If configuration is changed, update this class for your configuration.
    """

    num_input_ports: int = 8
    num_output_ports: int = 12
    num_valid_ports: int = 4
    num_drop_ports: int = 8
    input_labels: Tuple[str] = ('MAC0-RX', 'MAC1-RX', 'MAC2-RX', 'MAC3-RX',
                                'EFCrafter0', 'EFCrafter1', 'EFCrafter2', 'EFCrafter3')
    output_labels: Tuple[str] = ('MAC0-TX', 'MAC1-TX', 'MAC2-TX', 'MAC3-TX',
                                'Drop', 'Drop', 'Drop', 'Drop',
                                'Drop', 'Drop', 'Drop', 'Drop')

def default_axis_switch_config_table() -> AxisNetSwitchConfig:
    """Returns default AxisNetSwitchConfig instance.

    Returns:
        AxisNetSwitchConfig: default config table.
    """
    return AxisNetSwitchConfig()

def default_axis_switch_config_table_10g() -> AxisNetSwitchConfig:
    """Returns default AxisNetSwitchConfig instance.

    Returns:
        AxisNetSwitchConfig: default config table for 10G.
    """
    config_table_10g = AxisNetSwitchConfig()
    config_table_10g.num_input_ports = 16
    config_table_10g.num_output_ports = 16
    config_table_10g.num_valid_ports = 8
    config_table_10g.num_drop_ports = 8
    config_table_10g.input_labels = ('MAC0-RX', 'MAC1-RX', 'MAC2-RX', 'MAC3-RX',
                                    'MAC4-RX', 'MAC5-RX', 'MAC6-RX', 'MAC7-RX',
                                    'EFCrafter0', 'EFCrafter1', 'EFCrafter2', 'EFCrafter3',
                                    'EFCrafter4', 'EFCrafter5', 'EFCrafter6', 'EFCrafter7')
    config_table_10g.output_labels = ('MAC0-TX', 'MAC1-TX', 'MAC2-TX', 'MAC3-TX',
                                    'MAC4-TX', 'MAC5-TX', 'MAC6-TX', 'MAC7-TX',
                                    'Drop', 'Drop', 'Drop', 'Drop',
                                    'Drop', 'Drop', 'Drop', 'Drop')
    return config_table_10g
