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
    parser = argparse.ArgumentParser('set_max_residence_time', description='Set MaxResidenceTime for ATS scheduler group')
    parser.add_argument('port', type=int, help='MAC RX port')
    parser.add_argument('tc', type=int, help='Target TC value (6 or 7)')
    parser.add_argument('max_residence_time', nargs='?', default=None, type=int_or_none, help='MaxResidenceTime (ps). If omitted, show current status')
    parser.add_argument('--jtag_target', type=int, default=-1, help='AXI JTAG target. If omitted, select interactively')
    parser.add_argument('--board', default='kc705', choices=['kc705', 'zedboard'], help='Target board')
    args = parser.parse_args()

    available_tcs = [6, 7]
    if args.tc not in available_tcs:
        raise ValueError(f'args.tc ({args.tc}) must be in {available_tcs}')

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

    if args.max_residence_time is not None:
        switch.set_max_residence_time(args.port, args.tc, args.max_residence_time)
        print('Updated.')

    mrt = switch.get_max_residence_time(args.port, args.tc)

    print('Show current max residence time value:')
    print(f'  Target Port        : {args.port}')
    print(f'  Target TC          : {args.tc}')
    print(f'  Max Residence Time : {mrt / 1000000.0} us')

if __name__ == '__main__':
    main()
