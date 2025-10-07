# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import argparse
from pyxsdb import PyXsdb
from ats_switch import AtsSwitch


def int_or_none(x):
    return None if x is None else int(x)


def main():
    parser = argparse.ArgumentParser('set_processing_delay_max', description='Modify processing_delay_max value')
    parser.add_argument('processing_delay_max', nargs='?', default=None, type=int_or_none, help='Processing Delay Max (PDM) value in ps. If omitted, show current status')
    parser.add_argument('--jtag_target', type=int, default=-1, help='AXI JTAG target. If omitted, select interactively')
    parser.add_argument('--board', default='kc705', choices=['kc705', 'zedboard'], help='Target board')
    args = parser.parse_args()

    # Open xsdb connection
    xsdb = PyXsdb()
    xsdb.connect()

    # Select target
    target = args.jtag_target
    if target == -1:
        target = xsdb.select_target()
    xsdb.target(target)

    # Open CBS Switch
    switch = AtsSwitch(xsdb, target, args.board)

    if args.processing_delay_max is not None:
        switch.set_processing_delay_max(args.processing_delay_max)
        print('Updated')

    pdm = switch.get_processing_delay_max()

    print('Show current processing delay max value:')
    print(f'  Processing Delay Max: {pdm} ps')


if __name__ == '__main__':
    main()
