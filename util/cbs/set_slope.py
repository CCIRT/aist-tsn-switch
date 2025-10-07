# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import argparse
from pyxsdb import PyXsdb
from cbs_switch import CbsSwitch


def int_or_none(x):
    return None if x is None else int(x)


def main():
    parser = argparse.ArgumentParser('set_slope', description='Change the values of idleSlope and sendSlope')
    parser.add_argument('tc', type=int, help='Target TC value (6 or 7)')
    parser.add_argument('idle_slope', nargs='?', type=int_or_none, help='idleSlope value (kbps). If omitted, show current status')
    parser.add_argument('send_slope', nargs='?', type=int_or_none, help='sendSlope value (kbps). If omitted, show current status')
    parser.add_argument('--hi_credit', type=int, default=0x7fff_ffff, help='high credit value')
    parser.add_argument('--lo_credit', type=int, default=0x8000_0000, help='low credit value')
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
    switch = CbsSwitch(xsdb, target, args.board)

    if args.idle_slope is not None and args.send_slope is not None:
        switch.set_slope(args.tc, args.idle_slope, args.send_slope,
                         hi_credit=args.hi_credit,
                         lo_credit=args.lo_credit)
        print('Updated')

    idle_slope, send_slope, hi_credit, lo_credit = switch.get_slope(args.tc)
    print('Show current CBS status.')
    print(f'  Target TC: {args.tc}')
    print(f'  idleSlope: {idle_slope} kbps')
    print(f'  sendSlope: {send_slope} kbps')
    print(f'  HiCredit: {hi_credit} kbps')
    print(f'  LoCredit: {lo_credit} kbps')


if __name__ == '__main__':
    main()
