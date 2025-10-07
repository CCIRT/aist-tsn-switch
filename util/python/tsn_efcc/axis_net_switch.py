# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

from dataclasses import dataclass
import pyxsdb
import sys
import time
from typing import Union, List, Tuple, TextIO, Dict, TypeVar
from .device_property import TsnEfccAddressTable
from .device_property import AxisNetSwitchConfig

class AxisNetSwitch:
    """Controls TSN-EFCC's internal axis switch

    The switch connection is configure by the following functions.

    - start_config()
    - connect(input_port, output_port)
    - commit()

    start_config() starts the configuration of the switch.
    You must call this function at first, otherwise, exception will be raised.

    connect() connects input port and output port.
    You can call this function any times before commit().
    If a input is not connected to any port, it is connected to drop port at commit() function.

    commit() commits the configuration of the switch.
    When this function is called, the FPGA registers are configured and switch status is updated.
    """

    def __init__(self, xsdb: pyxsdb.PyXsdb, xsdb_target: int, addr_table: TsnEfccAddressTable, config: AxisNetSwitchConfig = AxisNetSwitchConfig()):
        """initialize AxisNetSwitch.

        Args:
            xsdb (pyxsdb.PyXsdb): PyXsdb object (connect() method must be called before)
            xsdb_target (int): The AXI JTAG target of TSN-EFCC.
            addr_table (TsnEfccAddressTable): The address table of TSN-EFCC.
            config (AxisNetSwitchConfig): The configuration of AxisNetSwitch.
        """
        self.xsdb = xsdb
        self.xsdb_target = xsdb_target
        self.efcc_type = addr_table.efcc_type
        if self.efcc_type == '1g':
            self.switch_addr = addr_table.axis_net_switch
        elif self.efcc_type == '10g':
            self.switch_addr = addr_table.axis_net_switch[0]
            self.switch_addr2 = addr_table.axis_net_switch[1]
        self.commit_hash = addr_table.commit_hash
        self.config = config
        self.started = False

        # Start initial configuration.
        # If commit() is called immediately, all input ports are connected to drop port.
        self.start_config()
        self.commit()

    def start_config(self) -> None:
        """Start configuration.

        Start configuration of the switch.
        The configuration must be completed by commit() function call.

        Returns:
            None: none
        """
        if self.started:
            raise ValueError('start_config is called again before commit().')
        self.started = True
        self.unassigned_inputs = list(range(self.config.num_input_ports))
        self.mapping = [0x80000000] * self.config.num_output_ports

        if self.efcc_type == '10g':
            self.unassigned_inputs2 = list(range(self.config.num_input_ports))
            self.mapping2 = [0x80000000] * self.config.num_output_ports

    def connect(self, input_port: int, output_port: int) -> None:
        """Connect input port and output port.

        Args:
            input_port (int): input port
            output_port (int): output port

        Returns:
            None: none
        """
        if not self.started:
            raise ValueError('connect must be called after start_config.')

        if input_port not in self.unassigned_inputs:
            raise ValueError(f'input port {input_port} was connected another output port')

        if self.mapping[output_port] != 0x80000000:
            raise ValueError(f'output port {output_port} was connected another input port {self.mapping[output_port]}')

        self.unassigned_inputs.remove(input_port)
        self.mapping[output_port] = input_port

        if self.efcc_type == '10g':
            if input_port >= self.config.num_valid_ports:
                input_port2 = input_port - self.config.num_valid_ports
                self.unassigned_inputs2.remove(input_port2)
                self.mapping2[input_port2] = input_port2

    def commit(self) -> None:
        """Commit configuration.

        After call of this function, the switch configuration is updated.

        Returns:
            None: none
        """
        if not self.started:
            raise ValueError('commit must be called after start_config.')

        self._set_xsdb_target()

        drop_idx = self.config.num_valid_ports
        for port in self.unassigned_inputs:
            self.mapping[drop_idx] = port
            drop_idx += 1
            if self.efcc_type == '10g':
                if drop_idx >= self.config.num_output_ports:
                    break

        port_addr_base = self.switch_addr + 0x40
        for i, m in enumerate(self.mapping):
            self.xsdb.mwr(port_addr_base + i * 4, m)

        self.xsdb.mwr(self.switch_addr, 0x2)

        if self.efcc_type == '10g':
            drop_idx2 = self.config.num_valid_ports
            for port in self.unassigned_inputs2:
                self.mapping2[drop_idx2] = port
                drop_idx2 += 1
                if drop_idx2 >= self.config.num_output_ports or port >= self.config.num_valid_ports:
                    break

            port_addr_base2 = self.switch_addr2 + 0x40
            for i, m in enumerate(self.mapping2):
                self.xsdb.mwr(port_addr_base2 + i * 4, m)

            self.xsdb.mwr(self.switch_addr2, 0x2)

        self.started = False

    def show_configuration(self, f=sys.stdout) -> None:
        """Show the current configuration to stdout or file.

        Args:
            f (file): Output file. (default: sys.stdout)

        Returns:
            None: none
        """
        self._set_xsdb_target()

        mapping = []
        for i in range(self.config.num_output_ports):
            input_port = self.xsdb.mrd(self.switch_addr + 0x40 + 0x4 * i)
            output_port = i
            mapping.append((input_port, output_port))

        # Since mapping is sorted by output_port, merge by input_port in ascending order
        mapping.sort(key=lambda x: x[0])

        if self.efcc_type == '1g':
            for i in range(self.config.num_input_ports):
                assert i == mapping[i][0]

                input_port = i
                output_port = mapping[i][1]

                print(f'input {self.config.input_labels[input_port]} -> {self.config.output_labels[output_port]}', file=f)

        elif self.efcc_type == '10g':
            # MAC-RX
            for i in range(self.config.num_valid_ports):
                assert i == mapping[i][0]

                input_port = i
                output_port = mapping[i][1]
                print(f'input {self.config.input_labels[input_port]} -> {self.config.output_labels[output_port]}', file=f)
            # Crafter
            for i in range(self.config.num_valid_ports):
                input_port = i + self.config.num_valid_ports
                found = False
                for j in range(self.config.num_input_ports):
                    if mapping[j][0] == input_port:
                        output_port = mapping[j][1]
                        print(f'input EFCrafter{i} -> {self.config.output_labels[output_port]}', file=f)
                        found = True
                        break
                if not found:
                    print(f'input EFCrafter{i} -> Drop', file=f)

        # if self.efcc_type == '10g':
        #     print('-------')
        #     print(f'ef_crafter AXIS Switch', file=f)
        #     mapping2 = []
        #     for i in range(self.config.num_output_ports):
        #         input_port = self.xsdb.mrd(self.switch_addr2 + 0x40 + 0x4 * i)
        #         output_port = i
        #         mapping2.append((input_port, output_port))

        #     # Since mapping2 is sorted by output_port, merge by input_port in ascending order
        #     mapping2.sort(key=lambda x: x[0])

        #     for i in range(self.config.num_valid_ports):
        #         assert i == mapping2[i][0]

        #         input_port = i
        #         output_port = mapping2[i][1]

        #         if output_port < self.config.num_valid_ports:
        #             print(f'input EFCrafter{input_port} -> Connect to Main AXIS Switch\'s EFCrafter{input_port} input', file=f)
        #         else:
        #             print(f'input EFCrafter{input_port} -> {self.config.output_labels[output_port]}', file=f)

    def get_commit_hash(self) -> int:
        """Get commit hash used to implement the current bitstream

        Args:
            None: none

        Returns:
            int: 8-digit Git commit hash
        """
        hash = self.commit_hash
        self._set_xsdb_target()
        return hex(self.xsdb.mrd(hash))


    def _set_xsdb_target(self):
        self.xsdb.target(self.xsdb_target)
