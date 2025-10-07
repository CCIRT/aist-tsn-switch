# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import argparse
from pyxsdb import PyXsdb
from ats_switch import AtsSwitch


def main():
    parser = argparse.ArgumentParser('manage_flow', description='Add/Delete flow definition')
    parser.add_argument('--jtag_target', type=int, default=-1, help='AXI JTAG target. If omitted, select interactively')
    parser.add_argument('--board', default='kc705', choices=['kc705', 'zedboard'], help='Target board')

    # Create subparser for add and del.
    subparsers = parser.add_subparsers(dest='action', help='Action. add, del or show')

    # Add parser
    add_parser = subparsers.add_parser('add', help='Add commands')
    add_parser.add_argument('port', type=int, help='MAC RX port')
    add_parser.add_argument('tc', type=int, help='Target TC value (6 or 7)')
    add_parser.add_argument('flow_id', type=int, help='Flow id value (1-15)')
    add_parser.add_argument('src_ip', nargs='?', default=None, help='Source IP (format: www.xxx.yyy.zzz or *(wildcard))')
    add_parser.add_argument('src_port', nargs='?', default=None, help='Source port (format: uint16 or *(wildcard))')
    add_parser.add_argument('dst_ip', nargs='?', default=None, help='Destination IP (format: www.xxx.yyy.zzz or *(wildcard))')
    add_parser.add_argument('dst_port', nargs='?', default=None, help='Destination port (format: uint16 or *(wildcard))')

    # Delete parser
    del_parser = subparsers.add_parser('del', help='Delete commands')
    del_parser.add_argument('port', type=int, help='MAC RX port')
    del_parser.add_argument('tc', type=int, help='Target TC value (6 or 7)')
    del_parser.add_argument('flow_id', type=int, help='Flow id value (1-15)')

    # Show parser
    show_parser = subparsers.add_parser('show', help='Show commands')
    show_parser.add_argument('port', type=int, help='MAC RX port')
    show_parser.add_argument('tc', type=int, help='Target TC value (6 or 7)')
    show_parser.add_argument('flow_id', type=int, help='Flow id value (1-15)')

    args = parser.parse_args()

    available_tcs = [6, 7]
    if args.tc not in available_tcs:
        raise ValueError(f'args.tc ({args.tc}) must be in {available_tcs}')

    available_flows = list(range(16))
    if args.flow_id not in available_flows:
        raise ValueError(f'args.flow_id ({args.flow_id}) must be in {available_flows}')

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

    if args.action == 'add':
        src_ip = None if args.src_ip == '*' else args.src_ip
        src_port = None if args.src_port == '*' else int(args.src_port)
        dst_ip = None if args.dst_ip == '*' else args.dst_ip
        dst_port = None if args.dst_port == '*' else int(args.dst_port)

        print('Added flow rule.')

        switch.add_flow_rule(args.port, args.tc, args.flow_id, src_ip, src_port, dst_ip, dst_port)

    elif args.action == 'del':
        print('Deleted flow rule.')
        switch.clear_flow_rule(args.port, args.tc, args.flow_id)

    elif args.action == 'show':
        pass

    else:
        raise ValueError('Please specify action option')

    src_ip, src_port, dst_ip, dst_port = switch.get_flow_rule(args.port, args.tc, args.flow_id)
    src_ip = '*' if src_ip is None else src_ip
    src_port = '*' if src_port is None else src_port
    dst_ip = '*' if dst_ip is None else dst_ip
    dst_port = '*' if dst_port is None else dst_port

    print('Show current flow status.')
    print(f'  Target Port      : {args.port}')
    print(f'  Target TC        : {args.tc}')
    print(f'  Target Flow      : {args.flow_id}')
    print(f'  Source IP        : {src_ip}')
    print(f'  Source port      : {src_port}')
    print(f'  Destination IP   : {dst_ip}')
    print(f'  Destination port : {dst_port}')


if __name__ == '__main__':
    main()
