# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import argparse
from pyxsdb import PyXsdb
from cbs_switch import CbsSwitch


def int0_or_none(x):
    return None if x is None else int(x, 0)

def main():
    parser = argparse.ArgumentParser('set_pulse', description='Change pulse_generator registers')
    parser.add_argument('--jtag_target', type=int, default=-1, help='AXI JTAG target. If omitted, select interactively')
    parser.add_argument('--board', default='kc705', choices=['kc705', 'zedboard', 'zedboard_with_probes'], help='Target board')

    # Create subparser for add and del.
    subparsers = parser.add_subparsers(dest='action', help='Action. probe or width')

    # probe
    probe_parser = subparsers.add_parser('probe', help='Set probe port')
    probe_parser.add_argument('output_pin', type=int0_or_none, help='output pin')
    probe_parser.add_argument('probe', nargs='?', default=None, type=int0_or_none, help='Probe value. If omitted, show current status')

    # width
    probe_parser = subparsers.add_parser('width', help='Set pulse width')
    probe_parser.add_argument('pulse_width', nargs='?', default=None, type=int0_or_none, help='Pulse width. If omitted, show current status')
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
    switch = CbsSwitch(xsdb, target, args.board)

    if args.action == 'probe':
        if args.probe is not None:
            switch.set_pulse_probes(args.output_pin, args.probe)
            print('Updated.')

        print('Show current probe value:')
        print(f'  Output pin: {args.output_pin}')
        print(f'  Mask: 0x{switch.get_pulse_probes(args.output_pin):010x}')

    elif args.action == 'width':
        if args.pulse_width is not None:
            switch.set_pulse_width(args.pulse_width)

        print('Show current pulse width:')
        print(f'  Pulse width: {switch.get_pulse_width()} cycles')
    else:
        raise ValueError('Please specify action')

if __name__ == '__main__':
    main()
