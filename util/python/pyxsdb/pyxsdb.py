# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

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

    def select_target(self) -> int:
        """Interact users to select target device by standard inout.

        Returns:
            int: selected target

        Raises:
            ValueError: If xsdb returns error
        """
        print('List of available targets are as below:')
        print(self.target())
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
        resp = self.sock.recv(MAX_RESP_SIZE)
        resp = resp.decode().strip()
        resp_arr = resp.split(' ')

        status = resp_arr[0]
        result = ' '.join(resp_arr[1:]).replace('\\n', '\n').strip()

        if status == 'okay':
            return result
        elif status == 'error':
            raise ValueError(f'xsdb command failed: msg={result}')

        raise ValueError(f'Unknown response: response={resp}')


if __name__ == '__main__':
    xsdb = PyXsdb()
    print(xsdb.connect())
    print(xsdb.target())
    print(xsdb.target(3))
    xsdb.select_target()
    print(f'0x{xsdb.mrd(0x40080000):08x}')
    print(xsdb.mwr(0x40080000, 0xffffffff))
    print(f'0x{xsdb.mrd(0x40080000):08x}')
