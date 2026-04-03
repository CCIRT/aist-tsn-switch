# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import argparse
from pyxsdb import PyXsdb
from ats_switch import AtsSwitch, DEFAULT_PRIO


def int_or_none(x):
    return None if x is None else int(x)


def main():
    parser = argparse.ArgumentParser('set_traffic_class', description='Set mapping rule from PCP to Traffic Class.')
    parser.add_argument('pcp', type=int, help='Target PCP value (-1 <= pcp < 8). -1 means non-VLAN-tagged frames')
    parser.add_argument('tc', nargs='?', default=None, type=int_or_none, help='Target TC value (0 <= tc < 8). If omitted, show current status')
    parser.add_argument('--jtag_target', type=int, default=-1, help='AXI JTAG target. If omitted, select interactively')
    parser.add_argument('--board', default='kc705', choices=['kc705', 'zedboard'], help='Target board')
    args = parser.parse_args()

    pcp = args.pcp
    if pcp == -1:
        pcp = DEFAULT_PRIO

    available_tcs = [0, 1, 2, 3, 4, 5, 6, 7]
    if args.tc is not None and args.tc not in available_tcs:
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

    if args.tc is not None:
        switch.set_traffic_class(pcp, args.tc)
        print('Updated.')

    print('Show current traffic_class status')
    print(f'  Target PCP: {args.pcp}')
    print(f'  Mapped TC: {switch.get_traffic_class(pcp)}')


if __name__ == '__main__':
    main()
