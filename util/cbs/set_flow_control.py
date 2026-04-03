# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import argparse
from pyxsdb import PyXsdb
from cbs_switch import CbsSwitch


def main():
    parser = argparse.ArgumentParser('set_flow_control', description='Enable/disable flow control and frame drop functions on RX path')
    parser.add_argument('flow_control_enable', nargs='?', default=None, type=int, help='flow control enable. If omitted, show current status')
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
    switch = CbsSwitch(xsdb, target, args.board)

    if args.flow_control_enable is not None:
        fc_en = args.flow_control_enable != 0
        switch.set_flow_control(fc_en)
        print('Updated.')

    print('Show current flow control status:')
    fc_en = switch.get_flow_control()
    dr_en = not fc_en
    print(f'  TEMAC flow control: {"ON" if fc_en else "OFF"}')
    print(f'  Frame drop functions: {"ON" if dr_en else "OFF"}')



if __name__ == '__main__':
    main()
