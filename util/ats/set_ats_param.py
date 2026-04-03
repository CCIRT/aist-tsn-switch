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
    parser = argparse.ArgumentParser('set_ats_param', description='Set Committed Information Rate (CIR) and Committed Burst Size (CBS) for a flow.')
    parser.add_argument('port', type=int, help='MAC RX port')
    parser.add_argument('tc', type=int, help='Target TC value (6 or 7)')
    parser.add_argument('flow_id', type=int, help='Flow id value (0-15)')
    parser.add_argument('committed_information_rate', nargs='?', default=None, type=int_or_none, help='Committed Information Rate (Mbps). If omitted, show current status')
    parser.add_argument('committed_burst_size', nargs='?', default=None, type=int_or_none, help='Committed Burst Size (Bytes). If omitted, show current status')
    parser.add_argument('--jtag_target', type=int, default=-1, help='AXI JTAG target. If omitted, select interactively')
    parser.add_argument('--board', default='kc705', choices=['kc705', 'zedboard'], help='Target board')
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

    if args.committed_information_rate is not None and args.committed_burst_size is not None:
        switch.set_ats_param(args.port, args.tc, args.flow_id,
                             args.committed_information_rate,
                             args.committed_burst_size)
        print('Updated.')

    cir, cbs = switch.get_ats_param(args.port, args.tc, args.flow_id)
    print('Show current ATS parameter.')
    print(f'  Target Port                : {args.port}')
    print(f'  Target TC                  : {args.tc}')
    print(f'  Target Flow                : {args.flow_id}')
    print(f'  Committed Information Rate : {cir} Mbps')
    print(f'  Committed Burst Size       : {cbs} Bytes')



if __name__ == '__main__':
    main()
