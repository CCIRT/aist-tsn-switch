# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import tkinter
import re
import shutil
import socket
import subprocess
from typing import Union, List


class PyXsdb:
    """Helper class to use xsdb via python API

    Example:

    >>> import pyxsdb
    >>> xsdb = pyxsdb.PyXsdb()
    xsdb server launched.
    >>> xsdb.connect()
    'tcfchan#0'
    >>> xsdb.target()
    '1  xc7k325t
     2  Legacy Debug Hub
        3  JTAG2AXI
     4  APU
     5  ARM Cortex-A9 MPCore #0 (Running)
     6  ARM Cortex-A9 MPCore #1 (Running)
     7  xc7z020
     8  Legacy Debug Hub
        9  JTAG2AXI'
    >>> xsdb.target(9)
    ''
    >>> xsdb.mrd(0x40080000)
    990000
    >>> xsdb.mwr(0x40080000, 100)
    ''
    >>> xsdb.mrd(0x40080000)
    100

    """

    def __init__(self):
        if shutil.which('xsdb') is None:
            raise ValueError('xsdb not found in PATH')

        # Launch xsdb server
        self.xsdb_server = subprocess.Popen(['xsdb', '-eval', 'xsdbserver start -host localhost'],
                                            text=True,
                                            stdin=subprocess.PIPE,
                                            stdout=subprocess.PIPE,
                                            stderr=subprocess.PIPE)
        # Read xsdb stdout
        xsdb_output = self.xsdb_server.stdout.readline()
        xsdb_server_port = int(re.match('.* port ([0-9]*)', xsdb_output).groups()[0])
        print(f'xsdb server launched.')

        # Create a socket which connects to the server
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.connect(('localhost', xsdb_server_port))

    def __del__(self):
        self.sock.sendall('exit\n'.encode())
        self.sock.close()

    def connect(self, url: str = '') -> str:
        """Run xsdb 'connect' command

        Args:
            url (str): The connect target. If omitted, run connect command without -url option.

        Returns:
            str: xsdb's standard output.

        Raises:
            ValueError: If xsdb returns error
        """
        if url == '':
            return self._send_msg('connect\n')
        return self._send_msg(f'connect -url {url}\n')

    def target(self, target_val: Union[int, None] = None) -> str:
        """Run xsdb 'target' command

        Args:
            target_val (int or None): The argument of target command. If set to None, run target without argument (Default: None)

        Returns:
            str: xsdb's standard output.

        Raises:
            ValueError: If xsdb returns error
        """
        if target_val is not None:
            return self._send_msg(f'target {target_val}\n')

        return self._send_msg('target\n')

    def describe_target(self) -> str:
        """Returns target list with jtag id

        Returns:
            str: device list

        Raises:
            ValueError: If xsdb returns error
        """
        parsed_data = self._decode_target_properties()
        pretty_format = ''
        for data in parsed_data:
            target_id = data['target_id']
            name = data['name']
            cable_name = data['jtag_cable_name']
            level = int(data['level'])
            indent = '    ' * level

            pretty_format += f'{indent}{target_id}: {name} ({cable_name})\n'

        return pretty_format

    def find_target_with_jtag_id(self, name: str, jtag_id: str) -> int:
        """Find target number with name and jtag_id.
        name: must be matched exactly. For example. "xc7z020", "JTAG2AXI"
        jtag_id: can be matched partially. For example. "2102400000" matches to "Digilent Zed 2102400000"

        Returns:
            int: target number

        Raises:
            ValueError: If xsdb returns error
            LookupError: If not matched or more than 2 targets are matched
        """

        parsed_data = self._decode_target_properties()
        matched = []
        for data in parsed_data:
            target_id = int(data['target_id'])
            cur_name = data['name']
            cur_cable_name = data['jtag_cable_name']

            if cur_name != name:
                continue

            if jtag_id not in cur_cable_name:
                continue

            matched.append(target_id)

        if len(matched) == 0:
            raise LookupError(f'Cannot find device with name {name} and jtag_id {jtag_id}')

        if len(matched) > 1:
            raise LookupError(f'Found multiple devices with name {name} and jtag_id {jtag_id}. Devices: {matched}')

        return matched[0]


    def select_target(self) -> int:
        """Interact users to select target device by standard inout.

        Returns:
            int: selected target

        Raises:
            ValueError: If xsdb returns error
        """
        print('List of available targets are as below:')
        print(self.describe_target())
        target = int(input('Please type the number of target: '))
        self.target(target)
        return target

    def mrd(self, addr: int) -> int:
        """Run xsdb 'mrd {addr}' command

        Args:
            addr (int): memory address

        Returns:
            int: memory value

        Raises:
            ValueError: If xsdb returns error
        """
        return int(self._send_msg(f'mrd {addr}\n').split(' ')[-1], 16)

    def mwr(self, addr: int, value: int) -> str:
        """Run xsdb 'mwr {addr} {value}' command

        Args:
            addr (int): memory address
            value (int): memory value

        Returns:
            None: None

        Raises:
            ValueError: If xsdb returns error
        """
        return self._send_msg(f'mwr {addr} {value}\n')

    def _send_msg(self, msg: str) -> str:
        MAX_RESP_SIZE = 1024

        self.sock.sendall(msg.encode())
        resp = ''
        while True:
            resp_raw = self.sock.recv(MAX_RESP_SIZE)
            resp += resp_raw.decode()

            if resp.endswith('\n'):
                break

        resp_arr = resp.split(' ')

        status = resp_arr[0]
        result = ' '.join(resp_arr[1:]).replace('\\n', '\n').strip()

        if status == 'okay':
            return result
        elif status == 'error':
            raise ValueError(f'xsdb command failed: msg={result}')

        raise ValueError(f'Unknown response: response={resp}')

    def _decode_target_properties(self):
        res = self._send_msg('target -target-properties\n')

        # decode properties
        tcl = tkinter.Tcl()
        raw_items = tcl.splitlist(res)
        parsed_data = []

        for item in raw_items:
            elems = tcl.splitlist(item)

            item_dict = {}
            for i in range(0, len(elems), 2):
                k = elems[i]
                v = elems[i+1]
                item_dict[k] = v

            parsed_data.append(item_dict)

        return parsed_data

if __name__ == '__main__':
    xsdb = PyXsdb()
    print(xsdb.connect())
    print(xsdb.target())
    print(xsdb.describe_target())
    print(xsdb.target(3))

    try:
        zedboard_id = xsdb.find_target_with_jtag_id('JTAG2AXI', 'Digilent Zed')
        print(f'ZedBoard found. id = {zedboard_id}')
    except LookupError as e:
        print(f'Cannot find unique zedboard. reason={e}')

    try:
        zedboard_id = xsdb.find_target_with_jtag_id('JTAG2AXI', 'hoge')
    except LookupError as e:
        print(f'Cannot find device hoge. reason={e}')

    xsdb.select_target()
    print(f'0x{xsdb.mrd(0x40080000):08x}')
    print(xsdb.mwr(0x40080000, 0xffffffff))
    print(f'0x{xsdb.mrd(0x40080000):08x}')
